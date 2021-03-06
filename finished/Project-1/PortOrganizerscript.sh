#!/bin/bash 

#Variables

Dir=$1

NmapList=$Dir/raw_out/PortOrganizer/ListForPortScript.txt
#-----------------------------------------------------------------------

read -t1

echo -e "\e[0;91mNow starting PortOrganizerscript\e[0m"
#-----------------------------------------------------------------------
echo ""
echo ""
#-----------------------------------------------------------------------
echo -e "\e[0;91m Creating directories \e[0m"
mkdir -p $Dir/raw_out/PortOrganizer
#-----------------------------------------------------------------------

cp $Dir/raw_out/nmap/ListForPortScript.txt $NmapList
#-----------------------------------------------------------------------

sed -i "/Up/d" $Dir/raw_out/PortOrganizer/ListForPortScript.txt
sed -i "/Nmap/d" $Dir/raw_out/PortOrganizer/ListForPortScript.txt
#-----------------------------------------------------------------------

echo -e "\e[0;91m Started finalizing. This can take a bit. \e[0m"

awk '{print $1}' $Dir/final_out/fqdnIP.txt | while read fqdn
do
    grep "($fqdn)" $NmapList >$Dir/raw_out/PortOrganizer/tmp.txt

    cut --complement -d' ' -f1,2,3 $Dir/raw_out/PortOrganizer/tmp.txt >$Dir/raw_out/PortOrganizer/tmp_filtered.txt

getline=$(awk 'NR==1' < $Dir/raw_out/PortOrganizer/tmp_filtered.txt)
getfqdnIPcsv=$(grep -E "^$fqdn" < $Dir/final_out/fqdnIP.csv)
getfqdntxt=$(grep -E "^$fqdn" < $Dir/final_out/fqdnIP.txt)

    echo -e "$getfqdnIPcsv,$getline" >> $Dir/final_out/fqdn_ip_ports.csv
    echo -e "$getfqdntxt $getline" >> $Dir/final_out/fqdn_ip_ports.txt

done
#-----------------------------------------------------------------------
