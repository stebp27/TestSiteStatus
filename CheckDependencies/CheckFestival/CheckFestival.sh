#!/usr/bin/env bash

#Controlla se il pacchetto festival è installato
installedFestival=$(which festival)
if [[ -z "$installedFestival" ]]
then
        if [[ $1 = "Ubuntu" ]] || [[ $1 = "Debian" ]]
        then
                sudo apt-get install festival
        elif [[ $1 = "Arch" ]]
        then
                pacman -S festival
        elif [[ $1 = "CentOS" ]]
        then
                yum install festival
        elif [[ $1 = "Fedora" ]]
        then
                dnf install festival
        else
                echo "You have to install the \"festival\" package for your DISTRO"
        fi
fi

