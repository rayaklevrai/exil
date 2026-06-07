#!/bin/bash

if echo $TERMUX_VERSION > /dev/null; then
	echo "environnement : termux $TERMUX_VERSION"
else
	echo "environnement is not termux"
	echo "if your are on android, please install termux"
	exit 1
fi

if ! command -v curl > /dev/null ; then
  echo "command curl not found, execute : pkg install curl"
  exit 1
fi


if ! command -v rish > /dev/null; then
  echo "please install rish via shizuku"
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
          
          if ! ls | grep app.txt > /dev/null  ; then
            touch app.txt
          fi
          if grep "$url" app.txt > /dev/null ; then
            echo "url already exist on app.txt, skip it."
          else
            echo $url >> app.txt
          fi
          files=`grep -oE '[^/]+$' 'app.txt'`
          
          if ls | grep "$files" > /dev/null  ; then
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
          
          
          rish -c pm install $files
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
          rish -c pm install $files
          if [ $4 = 1 ]; then
            exit 1
          elif [ $4 = 0 ]; then
            rm $files
          else
            rm $files
          fi
          ;;
      
        *)
          echo "please enter a valid parameter"
          ;;
      esac
        
    ;;
  --reset | -r)
    cat /dev/null > app.txt
    ;;
  *)
    echo "syntax : ./exil.sh
    -i/install : install package from curl
    -v/--version : print version
    --/--reset: reset app.txt
    "
    
  	;;
esac
