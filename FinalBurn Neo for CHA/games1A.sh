#! /bin/sh
# games1A.sh - FB Neo for Choko Hack v13.0.0

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


# Check if there is an USB pendrive
if [ -b /dev/sda ]
then
  # If not yet mounted, do it
  if ! grep -q /dev/sda1 /proc/mounts;
  then
    mount /dev/sda1 /mnt
  fi
  if ! grep -q /dev/sda /proc/mounts;
  then
    mount /dev/sda /mnt
  fi
  if grep -q /dev/sda /proc/mounts;
  then
    mkdir -p /mnt/fbneo /opt/fbneo
    mount --bind /mnt/fbneo /opt/fbneo
  fi
fi

_var_running_from_folder="$(dirname "$(readlink -f "$0")")"
if [ "$_var_running_from_folder" = "/.choko" ]
then
  /usr/sbin/fbneo -menu -unibios -joy &
else
  mkdir -p /opt/fbneo/config/games /opt/fbneo/support/hiscores
  if [ ! -e /opt/fbneo/support/hiscores/hiscore.dat ]
  then
    cp -v ./hiscore.dat /opt/fbneo/support/hiscores/
  fi
  ./fbneo -menu -unibios -joy &
fi

# Avoid capcom UI
touch /tmp/donotruncapcom
exit 0
