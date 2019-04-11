#!/usr/bin/env bash

#Controlla se il necessario è installato

~/SiteStatusScript/CheckDependencies/CheckDependencies.sh

pattern_1="[www.][a-zA-Z0-9]{1,}\.[a-z]{2,4}"
pattern_2="[a-zA-Z0-9]{1,}\.[a-z]{2,4}"
pattern_ip="[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
message=""

echo $1
echo $2

#verifica se ciò che ha ricevuto come parametro è valido
if [[ $1 =~ $pattern_1 ]] || [[ $1 =~ $pattern_2 ]] || [[ $1 =~ $pattern_ip ]]
then
	echo "Il parametro è giusto"
	code=$(curl -s -o /dev/null -w "%{http_code}" $1:$2)
	echo "Il codice è $code"	
else
	echo "Invalid url"
fi

#verifica della risposta
if [[ $code -eq 000 ]]
then
	echo "$code"
	message="Client abort"
	ruby ~/SiteStatusScript/RubyScripts/EmailRubySender.rb $3 $code
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
else
	echo "There's something wrong"
fi

#opzione -v
if [[ $4 = "-v" ]]
then
	echo $message
	#festival funziona tramite echo, ma non scrive il testo, lo legge solamente
	echo $message | festival --tts
fi
