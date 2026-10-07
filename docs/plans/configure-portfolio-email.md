# Configure Portfolio Email

**Status:** Planned and optional for the first website release; `mail@<DOMAIN>` is a requested address pattern, not a verified mailbox. Related: [Publish Portfolio Website](publish-portfolio-website.md).

## Requirement and choice

**2026-10-06 requirement and provider choice:** The operator wants a separate professional inbox for internships and other correspondence, with both inbound and outbound mail as `mail@<DOMAIN>` in Outlook on phone and desktop. This supersedes the earlier personal-Gmail destination preference. The Google Workspace selection was accidental. Choose **Zoho Mail Lite 5 GB**, pending domain registration, checkout price confirmation, and client tests; no mailbox or subscription is deployed. Cloudflare Email Routing alone only forwards incoming mail; [it cannot send or reply as the routed address](https://developers.cloudflare.com/email-service/reference/postmaster/#sending-or-replying-to-an-email-from-your-cloudflare-domain).

Zoho [lists Mail Lite 5 GB at US$1 per user/month billed yearly](https://www.zoho.com/mail/zohomail-pricing.html); the 10 GB tier is listed at US$1.25. Its [paid plan includes IMAP access](https://www.zoho.com/mail/help/adminconsole/subscription.html), and both [Outlook desktop](https://www.zoho.com/mail/help/outlook-imap-access.html) and [Outlook mobile](https://support.microsoft.com/en-us/outlook/how-do-i-set-up-an-imap-account) support an IMAP mailbox. IMAP syncs mail, not Outlook contacts or calendar. The [listed normal attachment limit is 30 MB](https://www.zoho.com/mail/zohomail-pricing.html), and [external sending is dynamically limited to 50-500 messages per hour](https://www.zoho.com/mail/help/adminconsole/rates-and-limits.html); this is for correspondence, not bulk mail. Zoho advertises a 99.9% uptime guarantee on its pricing page, but live delivery and reliability remain to be verified. If 5 GB becomes restrictive, check the 10 GB tier or migrate later.

**2026-10-06 budget and attachment clarification:** The operator prefers below US$25/year for the domain and email combined, with a US$40/year ceiling and the domain itself below US$20/year. Zoho's listed 5 GB annual charge is US$12 before tax. [Cloudflare's public `.com` registration/renewal list price](https://pricing.registrar.cloudflare.com/) is US$10.46/year on this date, implying approximately US$22.46/year before tax for one standard `.com` plus this mailbox. Taxes and a premium-name price could exceed the preferred target, so review the exact first-year and renewal totals privately at checkout. The candidate name has not been checked or purchased. The 30 MB limit applies to an ordinary outgoing email attachment; Zoho [documents up to 40 MB for an incoming message](https://www.zoho.com/mail/help/adminconsole/rates-and-limits.html) and a [250 MB Huge Attachment link](https://www.zoho.com/mail/help/attachments.html) for Mail Lite when composed in Zoho Mail. The link is not a normal email attachment and may require Zoho webmail rather than Outlook. Use a reviewed file-sharing link for larger files; test delivery with the recipient before relying on it.

Verify the checkout terms, custom-domain MX, authenticated outbound mail, and both Outlook clients before changing DNS. If the operator needs Outlook calendar and contacts synchronized too, revisit Exchange Online instead of assuming IMAP provides them. Do not rely on personal Gmail's third-party Send as feature for the permanent design: Google [announces its end in January 2027](https://support.google.com/mail/answer/22370?hl=en).

## Setup sequence

1. After domain registration, confirm Zoho Mail Lite 5 GB's current recurring cost, trial terms, Outlook compatibility, and cancellation path at checkout. Create `mail@` as a separate mailbox; enable account MFA and recovery. Keep login, app passwords, and recovery details out of this repository.
2. Add only the provider's verified MX, SPF, DKIM, and DMARC records in Cloudflare DNS, using its current instructions. Do not mix Cloudflare Email Routing MX records with a mailbox provider's MX records. Verify DNS and provider activation before publishing the address.
3. Add the mailbox to the chosen Outlook client. Send from two unrelated external accounts to `mail@`; confirm delivery to the separate inbox. Reply through Outlook and confirm the recipient sees `mail@` as From and Reply-To, with SPF/DKIM/DMARC passing.
4. Add the address to the website and resume only after inbound and outbound tests pass. Record the provider and verified behavior publicly without the private destination address, message contents, or raw headers.

## Recovery

If the domain mailbox fails, investigate its status and DNS without silently switching to an unverified forwarding-only route. A provider migration requires staged MX and authentication changes plus fresh inbound/outbound tests. Do not publish credentials, DNS verification tokens, or personal inbox identity in this repository.

## Later local mail archive

After the NAS is deployed, evaluate a private, read-only export or synchronized copy of selected mailboxes for local search and optional offline AI classification. Keep credentials, message bodies, attachments, and model inputs out of this public repository. Treat AI deletion suggestions as reviewable drafts; do not let an archive or sync job erase live provider mail. Decide scope, retention, access controls, and a verified export/restore path at that later stage. The 5 GB Zoho mailbox remains the current plan; no NAS mail archive or AI triage is deployed.
