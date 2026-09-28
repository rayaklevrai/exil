#!/bin/bash
# sorry if english is bad 😔
if [ -z "$TERMUX_VERSION" ]; then
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
for ((i=1; i<=$#; i++)); do
  if [[ ${!i} == "setup" ]]; then
    echo "choice your install method:
    root (su) : 1
    shizuku (rish) : 2"
    read -p "your choice: " choice
    if [[ $choice == "2" || $choice == "shizuku" || $choice == "rish" ]]; then
      if ! command -v rish > /dev/null; then
        echo "please install shizuku"
        break
      else
        choice="rish"
        echo $choice > .choice
      fi
    elif [[ $choice == "1" || $choice == "root" || $choice == "su" ]]; then
      if ! command -v su > /dev/null; then
        echo "this device isnt root or root not granted"
        break
      else
        choice=su
        echo $choice > .choice
      fi
    fi
    
  fi
done
  
    
    
    