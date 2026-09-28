#!/bin/bash
# sorry if english is bad 😔
if [ -z $TERMUX_VERSION ]; then
	echo "environnement is not termux"
	echo "if you are on android, please install termux"
	exit 1
fi
if ! command -v curl > /dev/null; then
  echo "command curl not found, execute : pkg install curl"
  exit 1
fi
# for debug :)
for ((i=1; i<=$#; i++)); do
  if [[ ${!i} == "-d" ]]; then
    echo "environnement : termux $TERMUX_VERSION"
    debug=true
  fi
done
#.....
if [[ $1 == "-i" || $1 == "install" ]]; then
  echo "enter choice for install:
      1) shizuku (rish)
      2) root (su)"
  read -p "your choice : " choice
  if [[ $choice == "shizuku" || $choice == "1" ]]; then
    if ! command -v rish > /dev/null; then
    echo "please install rish via shizuku"
    exit 1
    fi
    choice="rish"
    elif [[ $choice == "root" || $choice == "2"   ]]; then
    if ! command -v su > /dev/null ; then
      echo "command su not found"
      echo "please use shizuku or grant root access at termux"
    fi
    choice="su"
  fi
fi

