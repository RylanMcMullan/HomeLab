# Configure Portfolio Email

**Status:** Planned; `mail@<DOMAIN>` is a requested address pattern, not a verified mailbox. Related: [Publish Portfolio Website](publish-portfolio-website.md).

## Requirement and choice

The operator wants messages to reach an existing personal Gmail inbox **and** replies to leave as `mail@<DOMAIN>`. The recommended durable approach is a custom-domain mailbox with an email provider that supports sending and receiving, then optional forwarding or notifications to the personal Gmail inbox. Google Workspace Business Starter is a candidate because the operator already uses Gmail; its separate Workspace mailbox can be added to the Gmail app, and forwarding to personal Gmail can be configured after testing. Provider, price, and subscription are `TODO` until the operator reviews them. Cloudflare Email Routing alone only forwards incoming mail; [it cannot send or reply as the routed address](https://developers.cloudflare.com/email-service/reference/postmaster/#sending-or-replying-to-an-email-from-your-cloudflare-domain).

Do not rely on personal Gmail's third-party Send as feature for the permanent design: Google [announces its end in January 2027](https://support.google.com/mail/answer/22370?hl=en). If the operator selects a different mailbox provider, verify it supports custom-domain MX, authenticated outbound mail, client use, and forwarding or notification to Gmail before changing DNS.

## Setup sequence

1. After domain registration, choose the provider and confirm the current recurring cost, trial terms, and cancellation path. Create `mail@` using the provider's supported mailbox or alias setup; enable account MFA and recovery. Keep login and recovery details out of this repository.
2. Add only the provider's verified MX, SPF, DKIM, and DMARC records in Cloudflare DNS, using its current instructions. Do not mix Cloudflare Email Routing MX records with a mailbox provider's MX records. Verify DNS and provider activation before publishing the address.
3. Send from two unrelated external accounts to `mail@`; confirm delivery to the mailbox and, if selected, to personal Gmail. Reply from the custom-domain mailbox or configured mail client and confirm the recipient sees `mail@` as From and Reply-To, with SPF/DKIM/DMARC passing. Do not assume a forwarded copy can be replied to from personal Gmail with the custom From identity.
4. Add the address to the website and resume only after inbound and outbound tests pass. Record the provider and verified behavior publicly without the private destination address, message contents, or raw headers.

## Recovery

Keep the original Gmail inbox accessible. If the domain mailbox fails, investigate its status and DNS without silently switching to an unverified forwarding-only route. A provider migration requires staged MX and authentication changes plus fresh inbound/outbound tests. Do not publish credentials, DNS verification tokens, or personal inbox identity in this repository.
