#!/bin/bash 

[ "$1" = "" ] && echo "
    Please see '-h'
" && exit 1


#-----------------------------------------------------------------------
#Variables
  
  #domain
    domain=$2
  
  #name of new dir
    Dir=$3


while getopts ":hr" opt; do
  case ${opt} in
    h) echo "
      Usage:
       -h or --help : Show this
       -r : Run script

      Example:

       Display current page:
        ./MainScript.sh -h

       Running script:
       The script also creates the parent directories if they don't exist.

        ./MainScript.sh -r (Domain name) (Work directory or new work path + directory)

       String:
        ./MainScript -r example.com workdir
        ./MainScript -r example.com /new/path/workdir
        "
      ;;
    r)

        #-----------------------------------------------------------------------
        
        echo -e "\e[1;32m Making directories...... \e[0m"
        
            read -t0.5
        
            mkdir -p $Dir
            mkdir $Dir/final_out
            mkdir $Dir/raw_out
            mkdir $Dir/raw_out/Main
            read -t0.5
        #-----------------------------------------------------------------------
        echo""
        echo""
        #-----------------------------------------------------------------------
        
        echo -e "\e[1;32m Performing sublist3r scan on $domain...... \e[0m"
        echo""
        
        #touch $DIR/FQDNlist.txt
        #If sublist3r is just in a directory use this and change to right directory
        
            python3 /usr/share/sublist3r/sublist3r.py -d $domain -o $Dir/raw_out/Main/FQDNlist.txt
        
        #If you made an alias, function or symlink use this part and change name if needed
        
        #    sublister -d $domain -o $Dir/raw_out/Main/FQDNlist.txt
        
            List=$Dir/raw_out/Main/FQDNlist.txt
        #-----------------------------------------------------------------------
        echo""
        echo""
        #-----------------------------------------------------------------------
        
        echo -e "\e[1;32m Processes happeninge now: \e[0m"
        echo -e "\e[1;32m dig + awk command to get ip, \e[0m"
        echo -e "\e[1;32m saving output in $Dir/final_out/Main/ with form (fqdn,ip) and (fqdn ip) \e[0m"
        echo -e "\e[1;32m This may take a while \e[0m"

        echo""
        echo""
            read -t0.5
            cat $List | while read FQDN
            do
            dig -4 $FQDN +short > $Dir/raw_out/Main/tmp-lijst.txt
            #---------------------------
            wordcount=$(wc -l < $Dir/raw_out/Main/tmp-lijst.txt)
            getip=$(awk -v a=$wordcount 'NR==a' $Dir/raw_out/Main/tmp-lijst.txt)
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

      ;;

    \?) echo "
         Invalid argument $1

         See ./change-mac.sh -h for more info"
      ;;
  esac
done
