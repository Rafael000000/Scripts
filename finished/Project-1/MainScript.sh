#!/bin/bash 

#Variables
  
  #domain
    domain=$1
  
  #name of new dir
    Dir=$2
#-----------------------------------------------------------------------

echo -e "\e[1;32m Making directories...... \e[0m"

    read -t0.5

    mkdir -p $Dir
    mkdir $Dir/final_out
    mkdir $Dir/raw_out
    read -t0.5
#-----------------------------------------------------------------------
echo""
echo""
#-----------------------------------------------------------------------

echo -e "\e[1;32m Performing sublist3r scan on $domain...... \e[0m"
echo""

#touch $DIR/FQDNlist.txt
#If sublist3r is just in a directory use this and change to right directory

    python3 /usr/share/sublist3r/sublist3r.py -d $domain -o $Dir/raw_out/FQDNlist.txt

#If you made an alias, function or symlink use this part and change name if needed

#    sublister -d $domain -o FQDNlist.txt

    List=$Dir/raw_out/FQDNlist.txt
#-----------------------------------------------------------------------
echo""
echo""
#-----------------------------------------------------------------------

echo -e "\e[1;32m Processes happeninge now: \e[0m"
echo -e "\e[1;32m dig + awk command to get ip, \e[0m"
echo -e "\e[1;32m saving output in $Dir/final_out/ with form (fqdn,ip) and (fqdn ip) \e[0m"

echo""
echo""
    read -t0.5
    cat $List | while read FQDN
    do
    dig -4 $FQDN +short > $Dir/raw_out/tmp-lijst.txt
    #---------------------------
    wordcount=$(wc -l < $Dir/raw_out/tmp-lijst.txt)
    getip=$(awk -v a=$wordcount 'NR==a' $Dir/raw_out/tmp-lijst.txt)
    #---------------------------
    echo -e "$FQDN,$getip" >> $Dir/final_out/tmp-fqdnIP.csv
    echo -e "$FQDN $getip" >> $Dir/final_out/tmp-fqdnIP.txt
    #---------------------------
    sort $Dir/final_out/tmp-fqdnIP.txt > $Dir/final_out/fqdnIP.txt
    sort $Dir/final_out/tmp-fqdnIP.csv > $Dir/final_out/fqdnIP.csv
    #---------------------------
    done
    
    rm -rf $Dir/final_out/tmp-fqdnIP.txt $Dir/final_out/tmp-fqdnIP.csv

    read -t0.5

#-----------------------------------------------------------------------
echo""
echo""
#-----------------------------------------------------------------------
echo -e "\e[1;31mfinished MasterScript\e[0m"

sleep 1

echo -e "\e[1;31mStarting Nmapscript\e[0m"

sh Nmapscript.sh $Dir
