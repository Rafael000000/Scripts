#!/bin/bash -x

read -t1

echo -e "\e[0;91mNow running Nmapscript\e[0m"

#-----------------------------------------------------------------------

Dir=$1

fqdnip=$Dir/final_out/fqdnIP.txt

FQDNList=$Dir/raw_out/nmap/FQDNlist.txt

#-----------------------------------------------------------------------

    mkdir $Dir/raw_out/nmap/

#-----------------------------------------------------------------------

    awk '{print $1}' $fqdnip >>$Dir/raw_out/nmap/FQDNlist.txt

#-----------------------------------------------------------------------
# If you want to scan ALL the ports uncomment this:   
    #nmap -Pn -p- -iL $FQDNList -oG $Dir/raw_out/nmap/ScannedList.txt
    
    nmap -Pn -n -iL $FQDNList -oG $Dir/raw_out/nmap/ScannedList.txt
#-----------------------------------------------------------------------
    
    awk {'$1=""; print $0'} $Dir/raw_out/nmap/ScannedList.txt \
    >>$Dir/raw_out/nmap/ListTMscan.txt
#-----------------------------------------------------------------------

echo -e "\e[0;91mfinished Nmapscript\e[0m"

read -t1

echo -e "\e[0;91mNow starting PortIPorganizingscript\e[0m"

sh ~/ScriptingOrganized/Scripts/PortIPorganizingscript.sh $Dir
