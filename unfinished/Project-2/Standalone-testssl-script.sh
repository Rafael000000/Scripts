#!/bin/bash

[ "$1" = "" ] && echo "
    Please see '-h'
" && exit 1


#-----------------------------------------------------------------------
#Variables

Dir=$2
FQDNList=$3

#-----------------------------------------------------------------------
while getopts ":hr" opt; do
  case ${opt} in
    h) echo "
      Usage:
       -h or --help : Show this
       -r : Run script

      Example:

       Display current page:
        ./Standalone-testssl-script.sh -h

       Running script:
       The script also creates the parent directories if they don't exist.

        ./Standalone-testssl-script.sh -r (Work directory or new work path + directory) (FQDNlist or Path to FQDNlist)

       String:
        ./Standalone-testssl-script.sh -r workdir /path/to/FQDNlist.txt
        ./Standalone-testssl-script.sh -r /path/to/workdir FQDNlist.txt
        "
      ;;
    r)
      #-----------------------------------------------------------------------
      echo -e "\e[0;91m Now running Standalone-testssl-script \e[0m"
      
      #-----------------------------------------------------------------------
      echo -e "\e[1;32m Creating directories...... \e[0m"
      
      read -t0.5
      
      mkdir -p $Dir
      mkdir $Dir/final_out
      mkdir $Dir/raw_out
      read -t0.5
      
      #-----------------------------------------------------------------------
      echo ""
      echo ""
      
      #-----------------------------------------------------------------------
      echo -e "\e[0;91m Running Testssl command against the FQDN list\e[0m"
      echo -e "\e[0;91m This may take a while \e[0m"
      
          cat $FQDNList | while read list
          do
              testssl $list > $Dir/final_out/$list.txt
          done
      
      #-----------------------------------------------------------------------
      
      echo -e "\e[0;91mfinished Standalone-testssl-script\e[0m"
      ;;
    \?) echo "
         Invalid argument $1

         See ./Standalone-testssl-script.sh -h for more info"
      ;;
  esac
done
