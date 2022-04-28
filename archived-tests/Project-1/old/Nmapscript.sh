#!/usr/bin/env bash

read -t1

echo -e "\e[0;91mNow running Nmapscript\e[0m"

#-----------------------------------------------------------------------

dir=$1
Dir=$dir

Sort=~/ScriptingOrganized/$Dir/final_out/FQDNip.txt

FQDNList=~/ScriptingOrganized/$Dir/raw_out/nmap/FQDNlist.txt

#-----------------------------------------------------------------------

	mkdir ~/ScriptingOrganized/$Dir/raw_out/nmap/

#-----------------------------------------------------------------------

	awk '{print $1}' $Sort \
	>>~/ScriptingOrganized/$Dir/raw_out/nmap/FQDNlist.txt

#-----------------------------------------------------------------------

	nmap -Pn -iL $FQDNList -oX \
	~/ScriptingOrganized/$Dir/raw_out/nmap/ScannedList.txt

#-----------------------------------------------------------------------

#	awk {'print $1'} ~/ScriptingOrganized/$Dir/final_out/FQDNip.txt \
#	>>~/ScriptingOrganized/$Dir/final_out/ListTM.txt

#	cat ~/ScriptingOrganized/$Dir/raw_out/nmap/FQDNlist.txt | while read List
#	do
#	echo $List >>~/ScriptingOrganized/$Dir/raw_out/nmap/ListTM.txt
#	echo "" >>~/ScriptingOrganized/$Dir/raw_out/nmap/ListTM.txt
#	done

	awk {'$1=""; print $0'} \
	~/ScriptingOrganized/erasmusmc/raw_out/nmap/ScannedList.txt \
	>>~/ScriptingOrganized/erasmusmc/raw_out/nmap/ListTMscan.txt

#	exec 3<~/ScriptingOrganized/erasmusmc/raw_out/nmap/ListTMscan.txt
#	while read x; do read -u 3 y; echo $x $y; done \
#	<~/ScriptingOrganized/$Dir/raw_out/nmap/ListTM.txt \
#	>>~/ScriptingOrganized/$Dir/raw_out/nmap/MergedScanList.txt

echo -e "\e[0;91mfinished Nmapscript\e[0m"

read -t1

echo -e "\e[0;91mNow starting PortIPorganizingscript\e[0m"

sh ~/ScriptingOrganized/Scripts/PortIPorganizingscript.sh $Dir
