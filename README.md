# LinkMonkey_Bounty_Enumeration
This script runs the amass docker image so that subdomains can be found.

It nmaps each subdomain for ports 80 and 443.

For each subdomain listening on 80 and 443 curl is run and report is generated showing the http
status codes of each.

It produces two files in the /data directory containing subdomains and status codes

<domain_FINAL_PORT_80.txt>

<domain_FINAL_PORT_443.txt>


Usage:
```
./link_monkey.sh <domain>
```
