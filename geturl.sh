#!/bin/bash
#OpenAM Shell REST Client
#Wrapper for quickly calling curl to perform a GET against OpenAM

#check that URL is passed as an argument
if [ "$1" = "" ]; then
	echo "Argument missing.  Requires URL"
	exit
fi

#check that curl is present
CURL_LOC="$(which curl)"
if [ "$CURL_LOC" = "" ]; then
	echo "Curl not found.  Please install sudo apt-get install curl etc..."
	exit
fi

#check to see if .key exists from ./interactive.sh mode
if [ -e ".token" ]; then
		
	USER_AM_TOKEN=$(cat .token | cut -d "\"" -f 2) #remove start and end quotes

else

	echo "Token not found in .token file.  Use ./interactive.sh or ./authn_user_pw_default.sh to create"
	exit
fi

echo ""

URL=$1
curl -k --request GET --header "iplanetDirectoryPro: $USER_AM_TOKEN" $URL


