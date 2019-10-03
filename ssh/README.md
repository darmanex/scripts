### Hardening ssh config

Put the config above into sshd_config file at /etc/ssh/sshd_config. And test your ssh config with [ssh_scan](https://github.com/mozilla/ssh_scan) tool from [mozilla](https://github.com/mozilla).

eg: `./bin/ssh_scan -t 10.1.1.2 -p 22 -P config/policies/mozilla_modern.yml`

Make sure the result should be `grade A`.

Or you can use [NMAP](https://nmap.org) to check reports the number of algorithms (for encryption, compression, etc.)

eg: `sudo nmap -p22 -n -sV --script [ssh2-enum-algos][1] 10.1.1.2`

[1]: https://nmap.org/nsedoc/scripts/ssh2-enum-algos.html
