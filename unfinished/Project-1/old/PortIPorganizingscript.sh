#!/usr/bin/env bash

read -t1

echo -e "\e[0;91mNow starting PortIPorganizingscript\e[0m"

#-----------------------------------------------------------------------

#Vervang uiteindelijk 'erasmusmc' hiermee!!!!!!!!
dir=$1
Dir=$dir

List=~/ScriptingOrganized/$Dir/raw_out/nmap/ListTMscan.txt

#-----------------------------------------------------------------------

  mkdir ~/ScriptingOrganized/$Dir/Testing
  mkdir ~/ScriptingOrganized/$Dir/Testing/gettingReady
  mkdir ~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp
  mkdir ~/ScriptingOrganized/$Dir/Testing/gettingReady/uniqueSorted

  sed -e "/Up/d" $List >>~/ScriptingOrganized/$Dir/Testing/testingList.txt

  egrep "80" ~/ScriptingOrganized/$Dir/Testing/testingList.txt \
  >>~/ScriptingOrganized/$Dir/Testing/2portIPstmp.txt

  sed -e "/80/d" ~/ScriptingOrganized/$Dir/Testing/testingList.txt \
  >>~/ScriptingOrganized/$Dir/Testing/1portIPs.txt

  egrep "113" ~/ScriptingOrganized/$Dir/Testing/2portIPstmp.txt \
  >>~/ScriptingOrganized/$Dir/Testing/3portIPs.txt

  sed -e "/113/d" ~/ScriptingOrganized/$Dir/Testing/2portIPstmp.txt \
  >>~/ScriptingOrganized/$Dir/Testing/2portIPs.txt

#How to delete '/' from input file.!
  sed 's#/#\ #g' < ~/ScriptingOrganized/$Dir/Testing/1portIPs.txt \
  >>~/ScriptingOrganized/$Dir/Testing/gettingReady/1portIPs.txt

  sed 's#/#\ #g' < ~/ScriptingOrganized/$Dir/Testing/2portIPs.txt \
  >>~/ScriptingOrganized/$Dir/Testing/gettingReady/2portIPs.txt

  sed 's#/#\ #g' < ~/ScriptingOrganized/$Dir/Testing/3portIPs.txt \
  >>~/ScriptingOrganized/$Dir/Testing/gettingReady/3portIPs.txt

#-----------------------------------------------------------------------

#text color
#echo -e "\e[0;91mHello\e[0m"
#underline
#echo -e "\e[4;33mHiiiiiii\e[0m"

#-----------------------------------------------------------------------

#1portIPs

awk {'print $1,$4'} ~/ScriptingOrganized/$Dir/Testing/gettingReady/1portIPs.txt \
>>~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/1portIPstmp.txt

sed 's# #:#g' < ~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/1portIPstmp.txt \
>>~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/1portIPstmpP2.txt

sort -u ~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/1portIPstmpP2.txt \
>>~/ScriptingOrganized/$Dir/Testing/gettingReady/uniqueSorted/1portIPsorted.txt

#2portIPs

awk {'print $1,$4'} ~/ScriptingOrganized/$Dir/Testing/gettingReady/2portIPs.txt \
>>~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/2portIPstmp.txt

awk {'print $1,$9'} ~/ScriptingOrganized/$Dir/Testing/gettingReady/2portIPs.txt \
>>~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/2portIPstmp.txt

sed 's# #:#g' < ~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/2portIPstmp.txt \
>>~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/2portIPstmpP2.txt

sort -u ~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/2portIPstmpP2.txt \
>>~/ScriptingOrganized/$Dir/Testing/gettingReady/uniqueSorted/2portIPsorted.txt

#3portIPs

awk {'print $1,$4'} ~/ScriptingOrganized/$Dir/Testing/gettingReady/3portIPs.txt \
>>~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/3portIPstmp.txt

awk {'print $1,$9'} ~/ScriptingOrganized/$Dir/Testing/gettingReady/3portIPs.txt \
>>~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/3portIPstmp.txt

awk {'print $1,$14'} ~/ScriptingOrganized/$Dir/Testing/gettingReady/3portIPs.txt \
>>~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/3portIPstmp.txt

sed 's# #:#g' < ~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/3portIPstmp.txt \
>>~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/3portIPstmpP2.txt

sort -u ~/ScriptingOrganized/$Dir/Testing/gettingReady/tmp/3portIPstmpP2.txt \
>>~/ScriptingOrganized/$Dir/Testing/gettingReady/uniqueSorted/3portIPsorted.txt

#-----------------------------------------------------------------------

  cd ~/ScriptingOrganized/$Dir/Testing/gettingReady/uniqueSorted/

  cat 1portIPsorted.txt 2portIPsorted.txt 3portIPsorted.txt \
  >>portIPs.txt

  sort portIPs.txt >>~/ScriptingOrganized/$Dir/final_out/PortandIPsorted.txt

#-----------------------------------------------------------------------

echo -e "\e[0;91mfinished PortIPorganizingscript\e[0m"

read -t1

echo -e "\e[0;91mstarting testsslScript now\e[0m"

sh ~/ScriptingOrganized/testsslScript.sh $Dir


#-----------------------------------------------------------------------
