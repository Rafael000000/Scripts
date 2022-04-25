#!/usr/bin/env bash

#Variables
  
  #domain
    domain=$1
  
  #name of new dir
    Dir=$2
#-----------------------------------------------------------------------

echo -e "\e[1;32mMaking directories......\e[0m"

    read -t0.5

    mkdir -p $Dir
    #chmod -R $Dir
    mkdir $Dir/final_out
    mkdir $Dir/raw_out
    read -t0.5
#-----------------------------------------------------------------------
echo""
echo""
#-----------------------------------------------------------------------

echo -e "\e[1;32mPerforming sublist3r scan on $Domain......\e[0m"
echo""

#touch $DIR/FQDNlist.txt
#If sublist3r is just in a directory use this and change to right directory

    python3 /usr/share/sublist3r/sublist3r.py -d $domain -o $Dir/FQDNlist.txt

#If you made an alias, function or symlink use this part and change name if needed

#    sublister -d $domain -o FQDNlist.txt

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
    dig -4 $FQDN +short > tmp-lijst.txt
    wordcount=$(wc -l < tmp-lijst.txt)
    getip=$(awk -v a=$wordcount 'NR==a' tmp-lijst.txt)
    echo -e "$FQDN $getip" >> fqdnIP.txt
    done

    read -t0.5
#-----------------------------------------------------------------------
