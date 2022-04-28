#!/bin/bash 
[ "$1" = "" ] && echo "
    Please see '-h'
" && exit 1



#if [ $# -eq 1 ]
#  then
#    echo "
#    Please see '-h'
#    "
#    exit 1
#fi


#---------------------------------------------

while getopts ":hr" opt; do
  case ${opt} in
    h) echo "
      Usage:
       -h or --help : Show this
       -r : Run script

      Example:

       Display current page:
        ./change-mac.sh -h

       For changing mac addres:
        ./change-mac.sh -r (interface) (MAC address)

       For reverting changes:
        ./change-mac.sh -r (interface)

       String:
        ./change-mac -r wlan0 11:22:33:44:55"
      ;;
    r)

        PS3='Which command do you want to use?: '
        commands=("ip" "revert-with-ip" "ifconfig" "revert-with-ifconfig")
        select choice in "${commands[@]}"; do
            case $choice in
        #---------------------------
                "ip")
                    echo -e "\e[1;32m Changing mac address with (ip link)"
                    echo "#------------------------"
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Shutting down NetworkManager \e[0m"
                    sudo systemctl stop NetworkManager
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m This is your original mac-address \e[0m"
                    echo -e "\e[1;32m Saved under /home/$USER/original-mac-address.txt \e[0m"
                    ip a | grep -A 1 wlp54s0 | grep ether | awk {'print $2'} > /home/$USER/original-mac-address.txt
                    cat /home/$USER/original-mac-address.txt
                    #------------------------
                    echo -e "\e[1;32m Shutting down interface \e[0m"
                    sudo ip link set dev $2 down
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Changing MAC address \e[0m"
                    sudo ip link set dev $2 address $3
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Starting interface \e[0m"
                    sudo ip link set dev $2 up
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Starting NetworkManager \e[0m"
                    sudo systemctl start NetworkManager
                    echo ""
                    #------------------------
                    ip a | grep -A 3 $2
                    exit 0
                    ;;
        #---------------------------
                "ifconfig")
                    echo -e "\e[1;32m Changing mac address with (ifconfig) \e[0m"
                    echo "#------------------------"
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Shutting down NetworkManager \e[0m"
                    sudo systemctl stop NetworkManager
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m This is your original mac-address \e[0m"
                    ifconfig | grep -A 5 wlp54s0 | grep ether | awk {'print $2'}
                    ifconfig | grep -A 5 wlp54s0 | grep ether | awk {'print $2'} > /home/$USER/original-mac-address.txt
                    echo ""
                    #------------------------
                    echo -e"\e[1;32m Shutting down interface \e[0m"
                    sudo ifconfig $2 down
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Changing MAC address \e[0m"
                    sudo ifconfig $2 hw ether $3
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Starting interface \e[0m"
                    sudo ifconfig $2 up
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Starting NetworkManager \e[0m"
                    sudo systemctl start NetworkManager
                    sleep 3
                    echo ""
                    #------------------------
                    ip a | grep -A 3 $2
                    exit 0
                    ;;
        #---------------------------
                "revert-with-ip")
                    echo -e "\e[1;32m Reverting back changed mac address \e[0m"
                    echo "#------------------------"
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Shutting down NetworkManager \e[0m"
                    sudo systemctl stop NetworkManager
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Shutting down interface \e[0m"
                    sudo ip link set dev $2 down
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Reverting MAC address change \e[0m"
                    for output in $(cat /home/$USER/original-mac-address.txt)
                        do
                            sudo ip link set dev $2 address $output
                        done
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Starting interface \e[0m"
                    sudo ip link set dev $2 up
                    sleep 3
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Current mac address \e[0m"
                    ip a | grep -A 3 $2
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Starting NetworkManager \e[0m"
                    sudo systemctl start NetworkManager
                    sleep 3
                    echo ""
                    #------------------------
                    ip a | grep -A 3 $2
                    #------------------------
                    rm -f /home/$USER/original-mac-address.txt
                    exit 0
                    ;;
        #---------------------------
                "revert-with-ifconfig")
                    echo -e "\e[1;32m Reverting back changed mac address \e[0m"
                    echo "#------------------------"
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Shutting down NetworkManager \e[0m"
                    sudo systemctl stop NetworkManager
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Shutting down interface \e[0m"
                    sudo ifconfig $2 down
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Reverting MAC address change \e[0m"
                    for output in /home/$USER/original-mac-address.txt
                        do
                            sudo ifconfig $2 hw ether $output
                        done
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Starting interface \e[0m"
                    sudo ifconfig $2 up
                    sleep 3
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Current mac address\e[0m"
                    ifconfig | grep -A 5 wlp54s0 | grep ether | awk {'print $2'}
                    sleep 5
                    echo ""
                    #------------------------
                    echo -e "\e[1;32m Starting NetworkManager \e[0m"
                    sudo systemctl start NetworkManager
                    sleep 3
                    echo ""
                    #------------------------
                    ip a | grep -A 3 $2
                    #------------------------
                    rm -f /home/$USER/original-mac-address.txt
                    exit 0
                    ;;
        #---------------------------
                *) echo "invalid option $REPLY"
                   exit 1
                   ;;
            esac
        done


      ;;
    \?) echo "
         Invalid argument $1

         See ./change-mac.sh -h for more info"
      ;;
  esac
done

