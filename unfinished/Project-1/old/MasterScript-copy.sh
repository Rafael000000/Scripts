#!/usr/bin/env bash

[ "$1" = "-h" -o "$1" = "--help" ] && echo "
 Usage: 
  -h or --help : Show this 
  -r : Run script 

 Example: 
 ./master-script -h
 ./master-script -r (domain to hit) (work directory)
 ./master-script -r example.com example
" && exit


[ "$1" = "-r" -o "$1" = "--run" ] &&

echo -e "\e[1;31mNow running MasterScript\e[0m"

#list with FQDN's
#domainlist=$1
#List=$domainlist

#domain
	Domain=$2

#Name of new dir
	Dir=$3
#-----------------------------------------------------------------------
echo""
#-----------------------------------------------------------------------

echo -e "\e[1;32mMaking directories......\e[0m"

	read -t0.5

	#cd ~/ScriptingOrganized/
	mkdir $Dir
	chmod 744 $Dir
	cd $Dir
	mkdir final_out
	mkdir raw_out
	cd ..
	#cd ~/ScriptingOrganized/
	read -t0.5
#-----------------------------------------------------------------------
echo""
echo""
#-----------------------------------------------------------------------
echo -e "\e[1;32mPerforming sublist3r scan on $Domain......\e[0m"
echo""
#If sublist3r is just in a directory use this and change to right directory
#python3 ~/Sublist3r/sublist3r.py -d $Domain -o $Dir/FQDNlist.txt

#If you made an alias or function use this and change name if needed
sublist3r -d $Domain -o $Dir/FQDNlist.txt

	List=$Dir/FQDNlist.txt
#-----------------------------------------------------------------------
echo""
echo""
#-----------------------------------------------------------------------
echo -e "\e[1;32mNow performing resolveip command......\e[0m"
echo -e "\e[1;32mThis can take longer than expected......\e[0m"
echo -e "\e[1;32mDon't worry about the errors......\e[0m"
echo""
echo""
	read -t0.5
	cat $List | while read FQDN
	do
	resolveip $FQDN >>$Dir/raw_out/Hostout.txt
	done

	read -t0.5
#-----------------------------------------------------------------------
echo""
echo""
#-----------------------------------------------------------------------
echo -e "\e[1;32mNow performing awk command......\e[0m"
echo -e "\e[1;32mNow isolating FQDN and IP address......\e[0m"

	read -t0.5

	awk '{print $4}' $Dir/raw_out/Hostout.txt >>$Dir/raw_out/FQDN.txt |\
	awk '{print $6}' $Dir/raw_out/Hostout.txt >>$Dir/raw_out/ip.txt
#-----------------------------------------------------------------------
echo""
echo""
#-----------------------------------------------------------------------
echo -e "\e[1;32mMerging FQDN and IP address to one file......\e[0m"

	read -t0.5

	exec 3<$Dir/raw_out/ip.txt
	while read x; do read -u 3 y; echo $x $y; done \
	<$Dir/raw_out/FQDN.txt \
	>>$Dir/final_out/FQDNip.txt

	read -t0.5
#-----------------------------------------------------------------------
echo""
echo""
#-----------------------------------------------------------------------
echo -e "\e[1;32mSorting......\e[0m"
	sort $Dir/final_out/FQDNip.txt >>$Dir/final_out/FQDNip_Sorted.txt

	cd $Dir/final_out/

#-----------------------------------------------------------------------
echo""
echo""
#-----------------------------------------------------------------------
echo -e "\e[1;31mfinished MasterScript\e[0m"

sleep 1

echo -e "\e[1;31mStarting Nmapscript\e[0m"

#sh ~/ScriptingOrganized/Scripts/Nmapscript.sh $Dir
