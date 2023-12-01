#!/bin/sh
# games1C.sh - FinalBurn Neo for CHA (and cheats) Updater for Choko Hack v13.0.0

# Simple string compare, since until 10.0.0 CHOKOVERSION wasn't set
# Future versions need to keep this in mind
if [ -z "$CHOKOVERSION" ] || [ "$CHOKOVERSION" \< "13.0.0" ]
then
  echo -e "\nYou are running an outdated version of Choko Hack.\nYou need v13.0.0 or later.\n"
  _var_countdown=5
  while [ $_var_countdown -ge 0 ]
  do
    echo -ne "\rRebooting in $_var_countdown seconds... "
    _var_countdown=$((_var_countdown - 1))
    sleep 1
  done
  echo -e "\r                                   \r"
  if [ -z "$CHOKOVERSION" ] || [ "$CHOKOVERSION" \< "10.0.0" ]
  then
    reboot -f
  else
    exit 200
  fi
fi

_var_running_from_folder="$(dirname "$(realpath "$0")")"

echo -e "\nConnecting Wi-Fi..."
/etc/init.d/S40network restart > /dev/null 2>&1
_var_release_date="$(/.choko/busybox wget -q -o /dev/null -O - 'https://github.com/ChokoGroup/FBNeo/releases/tag/latest' | grep -m 1 'FinalBurn Neo for CHA (')"
_var_release_date="${_var_release_date#*FinalBurn Neo for CHA (}"; _var_release_date="${_var_release_date%%)*}"
_var_current_release_date="$(head -n 1 "${_var_running_from_folder}/fbneo_build_date.txt")"
if [ -z "$_var_release_date" ]
then
  echo "Could not get latest build date!"
elif [ -n "$_var_current_release_date" ] && [ "$_var_release_date" \< "$_var_current_release_date" ]
then
  echo -e "You are running a build dated $_var_current_release_date but the latest build date is ${_var_release_date}!?"
else
  [ -n "$_var_current_release_date" ] && echo "Current build date is $_var_current_release_date"
  echo -e "Latest build date is $_var_release_date\n"
  # Wait for buttons to be released
  while [ "$(readjoysticks j1 j2 -b)" != "0000000000000000" ]
  do
    sleep 1
  done
  _var_countdown=10
  _var_stop_countdown="N"
  _var_user_answer="No"
  while [ $_var_countdown -gt 0 ]
  do
    case "$(readjoysticks j1)" in
      U|D|L|R)
        [ "$_var_user_answer" = "No" ] && _var_user_answer="Yes" || _var_user_answer="No"
        [ "$_var_stop_countdown" = "N" ] && _var_stop_countdown="Y"
        echo -ne "\r\e[1ADo you want to update FinalBurn Neo for CHA? \e[1;93m$_var_user_answer \n\e[m\e[K"
      ;;
      0|1|2|3|4|5|6|7)
        _var_countdown=0
      ;;
      *)
        if [ "$_var_stop_countdown" = "N" ]
        then
          _var_countdown=$((_var_countdown - 1))
          echo -ne "\r\e[1ADo you want to update FinalBurn Neo for CHA? \e[1;93m$_var_user_answer \n\e[1;30mUse joystick to change answer. Waiting $_var_countdown seconds...\e[m "
        fi
      ;;
    esac
  done
  echo -ne "\r\e[1ADo you want to update FinalBurn Neo for CHA? \e[1;93m$_var_user_answer \n\e[m\e[K"
  if [ "$_var_user_answer" = "Yes" ]
  then
    echo "Downloading FinalBurn.Neo.for.CHA.zip"
    if /.choko/busybox wget -q -o /dev/null -O "/tmp/FinalBurn.Neo.for.CHA.zip" "https://github.com/ChokoGroup/FBNeo/releases/download/latest/FinalBurn.Neo.for.CHA.zip"
    then
      echo "Extracting files..."
      if unzip -qo "/tmp/FinalBurn.Neo.for.CHA.zip" -d /tmp
      then
        if [ "$_var_running_from_folder" = "/.choko" ]
        then
          cp "/tmp/FinalBurn Neo for CHA/fbneo" /usr/sbin/
          chmod 755 /usr/sbin/fbneo
          if [ -f "/.choko/FinalBurn Neo.sh" ]
          then
            cp "/tmp/FinalBurn Neo for CHA/games1A.sh" "/.choko/FinalBurn Neo.sh"
            cp "/tmp/FinalBurn Neo for CHA/games1A.nfo" "/.choko/FinalBurn Neo.nfo"
          fi
          if [ -f "/.choko/FinalBurn Neo (with bilinear filter).sh" ]
          then
            cp "/tmp/FinalBurn Neo for CHA/games1B.sh" "/.choko/FinalBurn Neo (with bilinear filter).sh"
            cp "/tmp/FinalBurn Neo for CHA/games1B.nfo" "/.choko/FinalBurn Neo (with bilinear filter).nfo"
          fi
          cp "/tmp/FinalBurn Neo for CHA/games1C.sh" "/.choko/FinalBurn Neo for CHA (and cheats) Updater.sh"
          cp "/tmp/FinalBurn Neo for CHA/games1C.nfo" "/.choko/FinalBurn Neo for CHA (and cheats) Updater.nfo"
          cp "/tmp/FinalBurn Neo for CHA/fbneo_build_date.txt" /.choko/fbneo_build_date.txt
          chmod 755 /.choko/*.sh
          chmod 644 /.choko/*.nfo
        else
          mv "/tmp/FinalBurn Neo for CHA"/* "$_var_running_from_folder"/
        fi
      else
        echo -e "\e[1;31mError extracting files from FinalBurn.Neo.for.CHA.zip!\e[m"
      fi
    else
      echo -e "\e[1;31mError downloading FinalBurn.Neo.for.CHA.zip!\e[m"
    fi
    echo -e "\e[0;32mFinalBurn Neo was updated with $(head -n 1 "${_var_running_from_folder}/fbneo_build_date.txt") build!\e[m"
    rm -rf /tmp/FinalBurn*
  fi
  echo -e "\n"
  # Wait for buttons to be released
  while [ "$(readjoysticks j1 j2 -b)" != "0000000000000000" ]
  do
    sleep 1
  done
  _var_countdown=10
  _var_stop_countdown="N"
  _var_user_answer="No"
  while [ $_var_countdown -gt 0 ]
  do
    case "$(readjoysticks j1)" in
      U|D|L|R)
        [ "$_var_user_answer" = "No" ] && _var_user_answer="Yes" || _var_user_answer="No"
        [ "$_var_stop_countdown" = "N" ] && _var_stop_countdown="Y"
        echo -ne "\r\e[1ADo you want to download/update the cheat files? \e[1;93m$_var_user_answer \n\e[m\e[K"
      ;;
      0|1|2|3|4|5|6|7)
        _var_countdown=0
      ;;
      *)
        if [ "$_var_stop_countdown" = "N" ]
        then
          _var_countdown=$((_var_countdown - 1))
          echo -ne "\r\e[1ADo you want to download/update the cheat files? \e[1;93m$_var_user_answer \n\e[1;30mUse joystick to change answer. Waiting $_var_countdown seconds...\e[m "
        fi
      ;;
    esac
  done
  echo -ne "\r\e[1ADo you want to download/update the cheat files? \e[1;93m$_var_user_answer \n\e[m\e[K"
  if [ "$_var_user_answer" = "Yes" ]
  then
    echo "Downloading cheats..."
    if /.choko/busybox wget -q -o /dev/null -O "/tmp/FBNeo-cheats-master.zip" "https://github.com/finalburnneo/FBNeo-cheats/archive/master.zip"
    then
      echo "Extracting cheat files..."
      if [ "$_var_running_from_folder" = "/.choko" ]
      then
        mkdir -p /opt/fbneo/support/cheats
        if unzip -ojq "/tmp/FBNeo-cheats-master.zip" *.ini -d /opt/fbneo/support/cheats
        then
          echo -e "\e[0;32mCheats are ready to use (P1 Start + Joystick Up during game emulation)\e[m"
        else
          echo -e "\e[1;31mError extracting FBNeo-cheats-master.zip!\e[m"
        fi
      else
        mkdir -p "/mnt/fbneo/support/cheats"
        if unzip -ojq "/tmp/FBNeo-cheats-master.zip" *.ini -d "/mnt/fbneo/support/cheats"
        then
          echo -e "\e[0;32mCheats are ready to use (P1 Start + Joystick Up during game emulation)\e[m"
        else
          echo -e "\e[1;31mError extracting FBNeo-cheats-master.zip!\e[m"
        fi
      fi
    else
      echo -e "\e[1;31mError downloading FBNeo-cheats-master.zip!\e[m"
    fi
    rm -rf /tmp/FBNeo*
  fi
  echo -en "\nWaiting for all files to be written..."
  sync
  while [ -n "$(pidof sync)" ]
  do
    sleep 1
    echo -en "."
  done
  echo -e "\r\e[K"
fi

_var_countdown=5
while [ $_var_countdown -ge 0 ]
do
  echo -ne "\rReturning to Choko Menu in $_var_countdown seconds... "
  _var_countdown=$((_var_countdown - 1))
  sleep 1
done
echo -e "\r                                                   \r"
# Go back to Choko Menu
exit 202
