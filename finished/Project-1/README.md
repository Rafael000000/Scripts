# Project-1

I created this project when I was an intern at Erasmus MC.

This project contains three main scripts. MainScript.sh, Nmapscript.sh, PortIPorganizingscript.sh.

### 1) MainScript.sh

This script uses [sublist3r](https://github.com/aboul3la/Sublist3r) to gather the subdomains of a
given domain. After the subdomains have been gathered they get put through the
[dig](https://linux.die.net/man/1/dig) command so that the ip addresses can be gathered. After this
has happened the FQDNs and the IP addresses get put side to side in a csv and a txt file.


