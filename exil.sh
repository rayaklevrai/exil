#!/bin/bash
# sorry if english is bad 😔
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
elif [[ $choice == "root" || $choice == "2" ]]; then
  if ! command -v su > /dev/null ; then
    echo "command su not found"
    echo "please use shizuku or grant root access at termux"
  fi
  choice="su"
fi

if [ ! -z $TERMUX_VERSION ]; then
	echo "environnement : termux $TERMUX_VERSION"
else
	echo "environnement is not termux"
	echo "if you are on android, please install termux"
	exit 1
fi
if ! command -v curl > /dev/null ; then
  echo "command curl not found, execute : pkg install curl"
  exit 1
fi
case $1 in
  -v | --version)
    echo "v0.1"
    echo "made by rayak"
    ;;
  -i | install)
      case $2 in
        --url)
          url=$3
          if [ ! -f app.txt ]; then
            touch app.txt
          fi
          if [ ! -f temp.txt ]; then
            touch temp.txt
          fi
          if grep "$url" app.txt > /dev/null ; then
            echo "url already exist on app.txt, skip it."
          else
            echo $url >> app.txt
          fi
          echo $url > temp.txt
          files=`grep -oE '[^/]+$' temp.txt`
          
          if [ -f "$files" ]  ; then
            echo "files already present, bypass download."
          else
            echo "Verif..."
            http_response=`curl -o /dev/null -s -w "%{response_code}" $url`
            if [ $http_response == "200" ] ; then
	            echo "code 200, perfect, continue"
            else
	            echo "code $http_response, dont perfect, exit 😔"
              exit 1
            fi
            echo "Downloading..."
            curl -s -O $url
          fi
          $choice -c pm install $files
          case $4 in
            --save | -s)
              echo "files is save"
              ;;
            *)
              echo "files is rm"
              rm $files
              ;;
          esac
          ;;
        --local | -l)
          files=$3
          $choice -c pm install $files
          case $4 in
            --save | -s)
              echo "files is save"
              ;;
            *)
              echo "files is rm"
              rm $files
              ;;
          esac
          ;;
        *)
          echo "please enter a valid parameter"
          ;;
      esac
        
    ;;
  --reset | -r)
    echo "️wiping...️"
    cat /dev/null > app.txt
    echo "wipe successful 🗑️"
    ;;
  *)
    echo "syntax : ./exil.sh
    -i/install : install package from curl
    -v/--version : print version
    -r/--reset: reset app.txt
    "
    
  	;;
esac