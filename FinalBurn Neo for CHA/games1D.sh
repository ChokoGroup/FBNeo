#!/bin/sh
# games1D.sh - (Un)Install FB Neo for Choko Hack v13.0.0

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
_var_countdown=10
_var_stop_countdown="N"
_var_user_answer="No"

if [ "$(ls -A /.choko/*FinalBurn*)" ]
then
  echo -e "\n"
  # Wait for buttons to be released before asking to delete
  while [ "$(readjoysticks j1 j2 -b)" != "0000000000000000" ]
  do
    sleep 1
  done
  while [ $_var_countdown -gt 0 ]
  do
    case "$(readjoysticks j1)" in
      U|D|L|R)
        [ "$_var_user_answer" = "No" ] && _var_user_answer="Yes" || _var_user_answer="No"
        [ "$_var_stop_countdown" = "N" ] && _var_stop_countdown="Y"
        echo -ne "\r\e[1ADo you want to delete fbneo and its roms from the CHA? \e[1;93m$_var_user_answer \n\e[m\e[K"
      ;;
      0|1|2|3|4|5|6|7)
        _var_countdown=0
      ;;
      *)
        if [ "$_var_stop_countdown" = "N" ]
        then
          _var_countdown=$((_var_countdown - 1))
          echo -ne "\r\e[1ADo you want to delete fbneo and its roms from the CHA? \e[1;93m$_var_user_answer \n\e[1;30mUse joystick to change answer. Waiting $_var_countdown seconds...\e[m "
        fi
      ;;
    esac
  done
  echo -ne "\r\e[1ADo you want to delete fbneo and its roms from the CHA? \e[1;93m$_var_user_answer \n\e[m\e[K"
  if [ "$_var_user_answer" = "Yes" ]
  then
    echo "Uninstalling FinalBurn Neo for CHA..."
    rm -rf /opt/fbneo
    rm -f /usr/sbin/fbneo
    rm -f /.choko/fbneo_build_date.txt
    rm /.choko/*FinalBurn*
    echo "FinalBurn Neo uninstalled."
  fi
  sleep 3
  _var_countdown=10
  _var_stop_countdown="N"
  _var_user_answer="No"

fi

echo -e "\n"
# Wait for buttons to be released
while [ "$(readjoysticks j1 j2 -b)" != "0000000000000000" ]
do
  sleep 1
done
while [ $_var_countdown -gt 0 ]
do
  case "$(readjoysticks j1)" in
    U|D|L|R)
      if [ "$_var_user_answer" = "No" ]
      then
        _var_user_answer="Yes (no filter)"
      elif [ "$_var_user_answer" = "Yes (no filter)" ]
      then
        _var_user_answer="Yes (bilinear filter)"
      elif [ "$_var_user_answer" = "Yes (bilinear filter)" ]
      then
        _var_user_answer="Yes (both)"
      else
        _var_user_answer="No"
      fi
      [ "$_var_stop_countdown" = "N" ] && _var_stop_countdown="Y"
      echo -ne "\r\e[1ADo you want to install fbneo and its roms in CHA? \e[1;93m$_var_user_answer                    \n\e[m\e[K"
    ;;
    0|1|2|3|4|5|6|7)
      _var_countdown=0
    ;;
    *)
      if [ "$_var_stop_countdown" = "N" ]
      then
        _var_countdown=$((_var_countdown - 1))
        echo -ne "\r\e[1ADo you want to install fbneo and its roms in CHA? \e[1;93m$_var_user_answer \n\e[1;30mUse joystick to change answer. Waiting $_var_countdown seconds...\e[m "
      fi
    ;;
  esac
done
echo -ne "\r\e[1ADo you want to install fbneo and its roms in CHA? \e[1;93m$_var_user_answer \n\e[m\e[K"
if [ "$_var_user_answer" != "No" ]
then
  echo -en "Installing FinalBurn Neo for CHA..."
  cp "$_var_running_from_folder/fbneo" /usr/sbin/
  chmod 755 /usr/sbin/fbneo
  echo -en "."
  if [ "$_var_user_answer" = "Yes (no filter)" ] || [ "$_var_user_answer" = "Yes (both)" ]
  then
    cp "$_var_running_from_folder/games1A.sh" "/.choko/FinalBurn Neo.sh"
    cp "$_var_running_from_folder/games1A.nfo" "/.choko/FinalBurn Neo.nfo"
  fi
  if [ "$_var_user_answer" = "Yes (bilinear filter)" ] || [ "$_var_user_answer" = "Yes (both)" ]
  then
    cp "$_var_running_from_folder/games1B.sh" "/.choko/FinalBurn Neo (with bilinear filter).sh"
    cp "$_var_running_from_folder/games1B.nfo" "/.choko/FinalBurn Neo (with bilinear filter).nfo"
  fi
  cp "$_var_running_from_folder/games1C.sh" "/.choko/FinalBurn Neo for CHA (and cheats) Updater.sh"
  cp "$_var_running_from_folder/games1C.nfo" "/.choko/FinalBurn Neo for CHA (and cheats) Updater.nfo"
  cp "$_var_running_from_folder/fbneo_build_date.txt" /.choko/fbneo_build_date.txt
  chmod 755 /.choko/*.sh
  chmod 644 /.choko/*.nfo
  echo -en "."
  mkdir -p /opt/fbneo/config/games /opt/fbneo/support/hiscores
  cp "$_var_running_from_folder/hiscore.dat" /opt/fbneo/support/hiscores/
  [ -f "$_var_running_from_folder/gamecontrollerdb.txt" ] && cp "$_var_running_from_folder/gamecontrollerdb.txt" /opt/fbneo/
  [ -d "/mnt/fbneo/config" ] && cp -r /mnt/fbneo/config /opt/fbneo/
  rm -f /opt/fbneo/config/roms.found
  echo -en "."
  [ -d "/mnt/fbneo/support" ] && cp -r /mnt/fbneo/support /opt/fbneo/
  echo -e "."
  _var_countdown=10
  _var_stop_countdown="N"
  _var_user_answer="No"
  if [ -d "/mnt/fbneo/roms" ] && [ "$(ls -A /mnt/fbneo/roms/)" ]
  then
    _var_free_space=$(df -P / | tail -1 | awk '{print $4}')
    _var_use_space_on_USB=$(du -c /mnt/fbneo/roms 2>/dev/null | tail -n 1 | awk '{print $1;}')
    if [ $((_var_use_space_on_USB)) -gt $((_var_free_space)) ]
    then
      echo -e "\nNot enought space to copy \"USB:/fbneo/roms\"."
    else
      echo -en "\n"
      while [ $_var_countdown -gt 0 ]
      do
        case "$(readjoysticks j1)" in
          U|D|L|R)
            if [ "$_var_user_answer" = "No" ]
            then
              _var_user_answer="Yes"
            else
              _var_user_answer="No"
            fi
            if [ "$_var_stop_countdown" = "N" ]
            then
              _var_stop_countdown="Y"
            fi
            echo -ne "\r\e[1ADo you want to copy the ROMs in USB:/fbneo/roms to the CHA? \e[1;93m$_var_user_answer \n\e[m\e[K"
          ;;
          0|1|2|3|4|5|6|7)
            _var_countdown=0
          ;;
          *)
            if [ "$_var_stop_countdown" = "N" ]
            then
              _var_countdown=$((_var_countdown - 1))
              echo -ne "\r\e[1ADo you want to copy the ROMs in USB:/fbneo/roms to the CHA? \e[1;93m$_var_user_answer \n\e[1;30mUse joystick to change answer. Waiting $_var_countdown seconds...\e[m "
            fi
          ;;
        esac
      done
      echo -ne "\r\e[1ADo you want to copy the ROMs in USB:/fbneo/roms to the CHA? \e[1;93m$_var_user_answer \n\e[m\e[K"
      if [ "$_var_user_answer" = "Yes" ]
      then
        echo -e "This can take time, please be patient...\e[1;30m"
        mkdir -p /opt/fbneo/roms
        cp -vr /mnt/fbneo/roms /opt/fbneo/
        echo -e "\e[m"
      fi
    fi
    _var_countdown=10
    _var_stop_countdown="N"
    _var_user_answer="No"
  fi
  if [ -d "/mnt/roms" ] && [ "$(ls -A /mnt/roms/)" ]
  then
    _var_free_space=$(df -P / | tail -1 | awk '{print $4}')
    _var_use_space_on_USB=$(du -c /mnt/roms 2>/dev/null | tail -n 1 | awk '{print $1;}')
    if [ $((_var_use_space_on_USB)) -gt $((_var_free_space)) ]
    then
      echo -e "\nNot enought space to copy \"USB:/roms\"."
    else
      echo -en "\n"
      while [ $_var_countdown -gt 0 ]
      do
        case "$(readjoysticks j1)" in
          U|D|L|R)
            if [ "$_var_user_answer" = "No" ]
            then
              _var_user_answer="Yes"
            else
              _var_user_answer="No"
            fi
            if [ "$_var_stop_countdown" = "N" ]
            then
              _var_stop_countdown="Y"
            fi
            echo -ne "\r\e[1ADo you want to copy the ROMs in USB:/roms to the CHA? \e[1;93m$_var_user_answer \n\e[m\e[K"
          ;;
          0|1|2|3|4|5|6|7)
            _var_countdown=0
          ;;
          *)
            if [ "$_var_stop_countdown" = "N" ]
            then
              _var_countdown=$((_var_countdown - 1))
              echo -ne "\r\e[1ADo you want to copy the ROMs in USB:/roms to the CHA? \e[1;93m$_var_user_answer \n\e[1;30mUse joystick to change answer. Waiting $_var_countdown seconds...\e[m "
            fi
          ;;
        esac
      done
      echo -ne "\r\e[1ADo you want to copy the ROMs in USB:/roms to the CHA? \e[1;93m$_var_user_answer \n\e[m\e[K"
      if [ "$_var_user_answer" = "Yes" ]
      then
        echo -e "This can take time, please be patient...\e[1;30m"
        mkdir -p /opt/fbneo/roms
        cp -rv /mnt/roms /opt/fbneo/
        echo -e "\e[m"
      fi
    fi
  fi
  echo "FinalBurn Neo installed."
else
  echo "FinalBurn Neo was NOT installed."
fi
echo -en "Waiting for all files to be written..."
sync
while [ -n "$(pidof sync)" ]
do
  sleep 1
  echo -en "."
done
echo -en "\n"

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
