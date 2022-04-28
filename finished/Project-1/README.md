# Project-1

I created this project when I was an intern at Erasmus MC.

This project contains three main scripts. MainScript.sh, Nmapscript.sh, PortIPorganizingscript.sh.

### 0) Required packages

Debian & Ubuntu:
* dnsutils (Because of dig command)
* Nmap
* [sublist3r](https://github.com/aboul3la/Sublist3r)

RHEL, Alma & CentOS:
* bind-utils (Because of dig command)
* Nmap
* [sublist3r](https://github.com/aboul3la/Sublist3r)

Archlinux & Archlinux-based:
* bind-tools (Because of dig command)
* Nmap
* [sublist3r](https://github.com/aboul3la/Sublist3r)

### 1) MainScript.sh

This script uses [sublist3r](https://github.com/aboul3la/Sublist3r) to gather the subdomains of a
given domain. After the subdomains have been gathered they get put through the
[dig](https://linux.die.net/man/1/dig) command so that the ip addresses can be gathered. After this
has happened the FQDNs and the IP addresses get put side by side in a csv and a txt file.

### 2) Nmapscript.sh

This script uses [nmap](https://github.com/nmap/nmap) to lookup the open ports of the subdomains we
just found. And outputs them in grepable format so that it can be used by PortOrganizerscript.

### 3) PortOrganizerscript.sh

This script adds the FQDNs, IP addresses and ports together in two files. A text file and a csv
file.
