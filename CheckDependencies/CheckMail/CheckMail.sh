#!/usr/bin/env bash

rubyInstalled=$(which ruby)
#Controlla se il pacchetto mail è installato
mailInstalled=$(gem list -i "mail")
if [[ -z "$rubyInstalled" ]]
then
	echo "Ruby is not installed yet"
else
	if !($mailInstalled)
	then
        	sudo gem install mail
	fi
fi

