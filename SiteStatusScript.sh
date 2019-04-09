#!/usr/bin/env bash

#Controlla se il pacchetto festival è installato
installed=$(which festival)
os=$(cat /etc/issue* | head -1 | cut -f 1 -d' ')
if [[ -z "$installed" ]]
then
	echo $os
	if [[ $os = "Ubuntu" ]] || [[ $os = "Debian" ]]
	then
		sudo apt-get install festival
	elif [[ $os = "Arch" ]]
	then
		pacman -S festival
	elif [[ $os = "CentOS" ]]
	then
		yum install festival
	elif [[ $os = "Fedora" ]]
	then
		dnf install festival
	else
		echo "You have to install the \"festival\" package for your DISTRO"
	fi
fi

pattern_1="[www.][a-zA-Z0-9]{1,}\.[a-z]{2,4}"
pattern_2="[a-zA-Z0-9]{1,}\.[a-z]{2,4}"
message=""

#verifica se ciò che ha ricevuto come parametro è valido
if [[ $1 =~ $pattern1 ]] || [[ $1 =~ $pattern2 ]] 
then
	code=$(printf "GET / HTTP/1.0\r\n\r\n" | nc $1 80 | head -1 | cut -f 2 -d' ')
	
else
	echo "Invalid url"
fi

#verifica della risposta
if [ $code -ge 100 ] && [ $code -lt 200 ]
then
        echo "$code"
	message="Informational"
elif [ $code -ge 200 ] && [ $code -lt 300 ]
then 
	echo "$code"
	message="Success"
elif [ $code -ge 300 ] && [ $code -lt 400 ]
then
	echo "$code"
	message="Redirection"
elif [ $code -ge 400 ] && [ $code -lt 500 ]
then
	echo "$code"
	message="Client Error"
elif [ $code -ge 500 ] && [ $code -lt 600 ]
then
	echo "$code"
	message="Server Error"
else
	echo "There\'s something wrong"
fi

#opzione -v
if [[ $2 = "-v" ]]
then
	echo $message
	#festival funziona tramite echo, ma non scrive il testo, lo legge solamente
	echo $message | festival --tts
fi
