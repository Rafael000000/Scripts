#!/bin/bash 

Dir=$1

fqdnip=$Dir/final_out/fqdnIP.txt

FQDNList=$Dir/raw_out/nmap/FQDNlist.txt

#-----------------------------------------------------------------------

read -t1

echo ""
echo ""

echo -e "\e[0;91m Now running Nmapscript \e[0m"
echo -e "\e[0;91m Everything from this script will be located in $Dir/raw_out/nmap \e[0m"

#-----------------------------------------------------------------------

    mkdir $Dir/raw_out/nmap/

#-----------------------------------------------------------------------

    awk '{print $1}' $fqdnip >$Dir/raw_out/nmap/FQDNlist.txt

#-----------------------------------------------------------------------
echo -e "\e[0;91m Running nmap command \e[0m"
echo -e "\e[0;91m This may take a while \e[0m"

# If you want to scan ALL the ports uncomment this:   
    #nmap -Pn -p- -iL $FQDNList -oG $Dir/raw_out/nmap/ScannedList.txt

    nmap -Pn -iL $FQDNList -oG $Dir/raw_out/nmap/ScannedList.txt
#-----------------------------------------------------------------------
    
    awk {'$1=""; print $0'} $Dir/raw_out/nmap/ScannedList.txt >$Dir/raw_out/nmap/ListForPortScript.txt
    
    sed -i "/Nmap/d" $Dir/raw_out/nmap/ListForPortScript.txt 
#-----------------------------------------------------------------------

echo -e "\e[0;91mfinished Nmapscript\e[0m"

read -t1

echo -e "\e[0;91mNow starting PortOrganizerscript\e[0m"

sh PortOrganizerscript.sh $Dir
