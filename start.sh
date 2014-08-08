#!/bin/bash

endpoint="auth.php"
port_num=$([ $# -eq 2 ] && echo "$2" || echo "5000")

function main() {
    check_tools
    check_args $1
    trap 'exit' ERR
    export_credentials
    start_server &
    start_ngrok
}

function check_tools() {
    if ! type ngrok &>/dev/null; then
        echo "Please install ngrok and create an account before running this script"
        echo "$(tput setaf 4)http://ngrok.com$(tput sgr0)"
        exit 1
    fi
}

function check_args() {
    if [ $# -lt 1 ] || [ $# -gt 2 ] || [ $1 == "--help" ] || [ $1 == "-h" ]
    then
        echo "please specify your preferred ngrok subdomain name, like so:"
        echo "./this-script.sh mysubdomain [port]"
        exit 1
    fi
    subdomain=$1
}

function export_credentials() {
    if  [ -z $TWILIO_ACCOUNT_SID ] || [ -z $TWILIO_AUTH_TOKEN ] || [ -z $TWILIO_APP_SID ]; then
        echo "What is your twilio account sid?"
        read account_sid

        echo "What is your auth token?"
        read auth_token

        echo "What is your TwiML app sid?"
        read app_sid

        export TWILIO_ACCOUNT_SID=$account_sid
        export TWILIO_AUTH_TOKEN=$auth_token
        export TWILIO_APP_SID=$app_sid
    fi
}

function start_server() {
    echo "starting php server on http://127.0.0.1:$port_num"
    echo "$(tput setaf 2)GET http://127.0.0.1:$port_num/$endpoint$(tput sgr0) to fetch a capability token for your iOS/Android app"
    php -S 127.0.0.1:$port_num
}

function start_ngrok() {
    ngrok -subdomain=$subdomain $port_num
}

main $@
