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
        ./Mainscript.sh -h

       Running script:
       The script also creates the parent directories if they don't exist.

        ./Mainscript.sh -r (Domain name) (Work directory or new work path + directory)

       String:
        ./Mainscript.sh -r example.com workdir
        ./Mainscript.sh -r example.com /new/path/workdir
        "
      ;;
    r)

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

        #If sublist3r is just in a directory use this and change to right directory

            python3 /usr/share/sublist3r/sublist3r.py -d $domain -o $Dir/raw_out/FQDNlist.txt

        #If you made an alias, function or symlink use this part

        #    <alias or function> -d $domain -o $Dir/raw_out/Main/FQDNlist.txt

        #-----------------------------------------------------------------------
        echo""
        echo""
        #-----------------------------------------------------------------------
        echo -e "\e[1;31mfinished Mainscriptcript\e[0m"

        sleep 1

        echo -e "\e[1;31mStarting Testsslscript\e[0m"

        sh Testsslscript.sh $Dir
        ;;

    \?) echo "
         Invalid argument $1

         See ./Mainscript.sh -h for more info"
      ;;
  esac
done




