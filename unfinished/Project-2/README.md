# Project-1

I created this project when I was an intern at Erasmus MC.

This project contains three scripts. Mainscript.sh, Testsslscript.sh, Standalone-testssl-script.sh.

### 0) Required packages

Debian & Ubuntu:
* [sublist3r](https://github.com/aboul3la/Sublist3r) (Not needed for the standalone script).
* testssl (Available in standard repos). [Debian package info](https://packages.debian.org/bullseye/testssl.sh). 
  [Github](https://github.com/drwetter/testssl.sh)

RHEL, Alma & CentOS:
* [sublist3r](https://github.com/aboul3la/Sublist3r) (Not needed for the standalone script).
* testssl (Available in standard repos). [Github](https://github.com/drwetter/testssl.sh)

Archlinux & Archlinux-based:
* [sublist3r](https://github.com/aboul3la/Sublist3r) (Not needed for the standalone script).
* testssl (Available in standard repos). [Arch package info](https://archlinux.org/packages/community/any/testssl.sh/).  [Github](https://github.com/drwetter/testssl.sh)

### 1) Mainscript.sh

This script uses [sublist3r](https://github.com/aboul3la/Sublist3r) to gather the subdomains of a given domain. After the subdomains have been gathered they get put in FQDNlist.txt so that it can be used in the next script.

More info about running the script can by giving -h as argument.

### 2) Testsslscript.sh

This script uses testssl checks the servers for the support of TLS/SSL ciphers, protocols as well as some cryptographic flaws. More info at [testssl.sh Github](https://github.com/drwetter/testssl.sh). It outputs them in multiple files. There will be one file per FQDN. 

Example:
www.example.com.txt


### 3) Standalone-testssl-script.sh

To use this script you only need the testssl script/package. This script assumes you already have a list with FQDN's to scan. You give the path to the FQDN list and the work directory as input of the script.

More info about running the script can by giving -h as argument.
