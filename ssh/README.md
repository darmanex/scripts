### Hardening ssh config

Put the config into sshd_config file at /etc/ssh/sshd_config. And test your ssh config with [ssh_scan](https://github.com/mozilla/ssh_scan) tool from [mozilla](https://github.com/mozilla). The result should be `grade A`.

eg: `./bin/ssh_scan -t 10.1.1.2 -p 22 -P config/policies/mozilla_modern.yml`

Or you can use [NMAP](https://nmap.org) to check reports the number of algorithms (for encryption, compression, etc.)

eg: `sudo nmap --script ssh2-enum-algos 10.1.1.2`
