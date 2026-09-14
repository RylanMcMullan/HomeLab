#!/usr/bin/env bash

# Read-only Linux and Proxmox inventory collector.
# This script intentionally avoids IP addresses, MAC addresses, serial numbers,
# credential files, and application command lines. Review its output anyway:
# device names, mount paths, service names, and hardware part numbers may still
# be private in your environment. Never commit raw output without sanitization.

set -u
export LC_ALL=C

section() {
  printf '\n## %s\n' "$1"
}

have() {
  command -v "$1" >/dev/null 2>&1
}

printf '%s\n' '# HomeLab read-only inventory'
printf '%s\n' 'Collection method: command-verified; sanitize before publication'
date -u '+Collected (UTC): %Y-%m-%dT%H:%M:%SZ'

section 'Operating system'
if [ -r /etc/os-release ]; then
  grep -E '^(PRETTY_NAME|VERSION_ID)=' /etc/os-release || true
fi
printf 'Kernel: %s\n' "$(uname -r)"
printf 'Architecture: %s\n' "$(uname -m)"
if have systemd-detect-virt; then
  virtualization="$(systemd-detect-virt 2>/dev/null || true)"
  [ -n "$virtualization" ] || virtualization='none detected'
  printf 'Virtualization: %s\n' "$virtualization"
fi

section 'CPU'
if have lscpu; then
  lscpu | grep -E '^(Architecture|CPU\(s\)|On-line CPU|Model name|Socket\(s\)|Core\(s\) per socket|Thread\(s\) per core|Virtualization):' || true
else
  printf '%s\n' 'lscpu unavailable'
fi

section 'Memory'
if have free; then
  free -h
else
  grep -E '^(MemTotal|MemAvailable|SwapTotal|SwapFree):' /proc/meminfo || true
fi

if [ "$(id -u)" -eq 0 ] && have dmidecode; then
  printf '\nMemory devices (serial numbers intentionally omitted):\n'
  dmidecode --type 17 2>/dev/null | grep -E '^\s*(Size|Form Factor|Locator|Type|Speed|Manufacturer|Part Number|Configured Memory Speed):' || true
else
  printf '%s\n' 'Memory-slot detail unavailable (root plus dmidecode required)'
fi

section 'Storage devices'
if have lsblk; then
  lsblk -d -e 7 -o NAME,SIZE,ROTA,TYPE,MODEL,TRAN 2>/dev/null || lsblk -d -o NAME,SIZE,ROTA,TYPE,MODEL 2>/dev/null || true
  printf '\nFilesystem capacity:\n'
  lsblk -e 7 -o NAME,SIZE,FSTYPE,FSAVAIL,FSUSE%,MOUNTPOINTS 2>/dev/null || true
else
  printf '%s\n' 'lsblk unavailable'
fi

section 'Graphics and accelerator hardware'
if have lspci; then
  lspci | grep -Ei '(VGA compatible controller|3D controller|display controller)' || printf '%s\n' 'No PCI display controller reported'
else
  printf '%s\n' 'lspci unavailable'
fi
if have nvidia-smi; then
  nvidia-smi --query-gpu=name,memory.total,driver_version --format=csv,noheader 2>/dev/null || true
fi

section 'System health snapshot'
uptime || true
if have ps; then
  printf '\nHighest-memory processes (arguments and usernames omitted):\n'
  ps -eo comm,%cpu,%mem,rss --sort=-rss 2>/dev/null | head -n 11 || true
fi
if have sensors; then
  sensors 2>/dev/null || true
else
  printf '%s\n' 'lm-sensors unavailable'
fi

section 'Proxmox platform'
if have pveversion; then
  pveversion --verbose || true

  if have pvesm; then
    printf '\nStorage capacity (storage names omitted):\n'
    pvesm status 2>/dev/null | awk '
      NR == 1 { print "TYPE STATUS TOTAL USED AVAILABLE USE%"; next }
      NR > 1 { print $2, $3, $4, $5, $6, $7 }
    ' || true
  fi

  if have pct; then
    container_count="$(pct list 2>/dev/null | awk 'NR > 1 { count++ } END { print count + 0 }')"
    printf '\nLXC count: %s\n' "$container_count"
    guest_number=0
    while IFS= read -r guest_id; do
      [ -n "$guest_id" ] || continue
      guest_number=$((guest_number + 1))
      printf 'LXC %s resources (ID and hostname omitted):\n' "$guest_number"
      pct config "$guest_id" 2>/dev/null | grep -E '^(arch|cores|cpulimit|cpuunits|features|memory|onboot|ostype|swap|unprivileged):' || true
      pct config "$guest_id" 2>/dev/null | awk -F'[,=]' '/^rootfs:/ { for (i=1; i<NF; i++) if ($i ~ /^size/) print "rootfs " $i "=" $(i+1) }' || true
      pct status "$guest_id" --verbose 2>/dev/null | grep -E '^(status|cpu|cpus|disk|maxdisk|maxmem|mem|swap|uptime):' || true
    done < <(pct list 2>/dev/null | awk 'NR > 1 { print $1 }')
  fi

  if have qm; then
    vm_count="$(qm list 2>/dev/null | awk 'NR > 1 { count++ } END { print count + 0 }')"
    printf '\nVM count: %s\n' "$vm_count"
    guest_number=0
    while IFS= read -r guest_id; do
      [ -n "$guest_id" ] || continue
      guest_number=$((guest_number + 1))
      printf 'VM %s resources (ID and name omitted):\n' "$guest_number"
      qm config "$guest_id" 2>/dev/null | grep -E '^(agent|balloon|bios|cores|cpu|memory|numa|onboot|ostype|scsihw|sockets):' || true
      qm config "$guest_id" 2>/dev/null | awk -F'[,=]' '/^(ide|sata|scsi|virtio)[0-9]+:/ { for (i=1; i<NF; i++) if ($i ~ /^size/) print "disk " $i "=" $(i+1) }' || true
      qm status "$guest_id" --verbose 2>/dev/null | grep -E '^(status|cpu|cpus|disk|maxdisk|maxmem|mem|uptime):' || true
    done < <(qm list 2>/dev/null | awk 'NR > 1 { print $1 }')
  fi
else
  printf '%s\n' 'Not a Proxmox VE host (pveversion unavailable)'
fi

section 'Runtime presence'
for runtime in docker podman java python3; do
  if have "$runtime"; then
    case "$runtime" in
      docker) docker --version 2>/dev/null || true ;;
      podman) podman --version 2>/dev/null || true ;;
      java) java -version 2>&1 | head -n 2 || true ;;
      python3) python3 --version 2>/dev/null || true ;;
    esac
  else
    printf '%s: unavailable\n' "$runtime"
  fi
done

section 'Review reminder'
printf '%s\n' 'Do not commit this raw output. Remove private identifiers and summarize only verified, repository-safe facts.'
