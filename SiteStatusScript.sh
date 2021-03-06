#!/usr/bin/env bash

#Controlla se il necessario è installato

~/SiteStatusScript/CheckDependencies/CheckDependencies.sh

pattern_1="[www.][a-zA-Z0-9]{1,}\.[a-z]{2,4}"
pattern_2="[a-zA-Z0-9]{1,}\.[a-z]{2,4}"
pattern_ip="[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
message=""

#verifica se ciò che ha ricevuto come parametro è valido
if [[ $1 =~ $pattern_1 ]] || [[ $1 =~ $pattern_2 ]] || [[ $1 =~ $pattern_ip ]]
then
	code=$(curl -s -o /dev/null -w "%{http_code}" $1:$2)	
else
	echo "Invalid url"
fi

#verifica della risposta
if [[ $code -eq 000 ]]
then
	echo "$code"
	message="Client abort"
	ruby ~/SiteStatusScript/RubyScripts/EmailRubySender.rb $3 $code
	echo "Warning, $1 is offline, AAAAAAAAAAAAAAAAAAAA" | festival --tts
elif [[ $code -ge 100 ]] && [[ $code -lt 200 ]]
then
        echo "$code"
	message="Informational"
elif [[ $code -ge 200 ]] && [[ $code -lt 300 ]]
then 
	echo "$code"
	message="Success"
	elif [[ $code -ge 300 ]] && [[ $code -lt 400 ]]
then
	echo "$code"
	message="Redirection"
elif [[ $code -ge 400 ]] && [[ $code -lt 500 ]]
then
	echo "$code"
	message="Client Error"
elif [[ $code -ge 500 ]] && [[ $code -lt 600 ]]
then
	echo "$code"
	message="Server Error"
	ruby ~/SiteStatusScript/RubyScripts/EmailRubySender.rb $3 $code
	echo "Warning, $1 is offline, damn!" | festival --tts
else
	echo "There's something wrong"
fi

#opzione -v
if [[ $4 = "-v" ]]
then
	echo "Request ended with code $code: $message"
	#festival funziona tramite echo, ma non scrive il testo, lo legge solamente
	echo "Request ended with code $code: $message" | festival --tts
fi
