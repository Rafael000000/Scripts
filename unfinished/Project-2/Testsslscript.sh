#!/bin/bash

Dir=$1

FQDNList=$Dir/raw_out/FQDNlist.txt

#-----------------------------------------------------------------------

read -t1

echo ""
echo ""

echo -e "\e[0;91m Now running Testsslscript \e[0m"

#-----------------------------------------------------------------------
echo -e "\e[0;91m Running Testssl command against the FQDN list\e[0m"
echo -e "\e[0;91m This may take a while \e[0m"

    cat $FQDNList | while read list
    do
        testssl $list > $Dir/final_out/$list.txt
    done

#-----------------------------------------------------------------------

echo -e "\e[0;91mfinished Testsslscript\e[0m"
