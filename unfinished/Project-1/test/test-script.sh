#!/bin/bash -x
    cat fqdn.txt | while read FQDN
    do
    dig -4 $FQDN +short > tmp-lijst.txt
    wordcount=$(wc -l < tmp-lijst.txt)
    getip=$(awk -v a=$wordcount 'NR==a' tmp-lijst.txt)
#>>$Dir/raw_out/ipout.txt
    echo -e "$FQDN $getip" >> tmp-out.txt
    done
