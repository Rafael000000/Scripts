#Script for jingpad with jingos
#
#-------------------------------------
echo "Getting installed apps list"

sudo japm list >> all-apps.txt
#-------------------------------------
echo "Uninstalling all apps"

cat all-apps.txt | while read LIST
do
sudo japm uninstall $LIST
done

rm -f all-apps.txt
#-------------------------------------
echo ""
echo ""
#-------------------------------------
echo "Removing android app support"

sudo apt purge android-compatible-env
#-------------------------------------
echo ""
echo ""
#-------------------------------------
echo "Do you also want to remove japm?"
echo "y/n"

read ans1

if [[ $ans1 == y ]]; then
    echo "Uninstalling japm..."
    sudo apt purge japm
    sudo apt autoremove
    sleep 1
else
   sleep 1
   echo "Continuing..."   
fi
#-------------------------------------
echo ""
echo ""
#-------------------------------------
echo "Do you want to reboot now?"
echo "y/n"

read ans2

if [[ $ans2 == y ]]; then
   echo "Rebooting...."
   sudo reboot now
else
   echo "Don't forget to reboot later."
   sleep 1
   exit
fi
#-------------------------------------
