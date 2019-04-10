#!/usr/bin/env bash

#Controlla se ruby è installato
installedRuby=$(which ruby)
if [[ -z "$installedRuby" ]]
then
        if [[ $1 = "Ubuntu" ]] || [[ $1 = "Debian" ]]
        then
                sudo apt-get install ruby
        elif [[ $1 = "Arch" ]]
        then
                pacman -S ruby
        elif [[ $1 = "CentOS" ]]
        then
                yum install ruby
        elif [[ $1 = "Fedora" ]]
        then
                dnf install ruby
        else
                echo "You have to install the \"Ruby\" package for your DISTRO"
        fi
fi

