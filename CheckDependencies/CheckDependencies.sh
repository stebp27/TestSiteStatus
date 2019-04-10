#!/usr/bin/env bash

os=$(cat /etc/issue* | head -1 | cut -f 1 -d' ')

~/SiteStatusScript/CheckDependencies/CheckRuby/CheckRuby.sh $os

~/SiteStatusScript/CheckDependencies/CheckMail/CheckMail.sh

~/SiteStatusScript/CheckDependencies/CheckFestival/CheckFestival.sh $os
