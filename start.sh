#!/bin/bash

script_name="auth.php"
port_num="5000"

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
    if [ $# -ne 1 ]; then
        echo "please specify your preferred ngrok subdomain name, like so:"
        echo "./this-script.sh mysubdomain"
        exit 1
    fi
    subdomain=$1
}

function export_credentials() {
    if  [ -z $ACCOUNT_SID ] || [ -z $AUTH_TOKEN ] || [ -z $APP_SID ]; then
        echo "What is your twilio account sid?"
        read account_sid

        echo "What is your auth token?"
        read auth_token

        echo "What is your TwiML app sid?"
        read app_sid

        export ACCOUNT_SID=$account_sid
        export AUTH_TOKEN=$auth_token
        export APP_SID=$app_sid
    fi
}

function start_server() {
    trap 'exit' ERR
    echo "starting php server on http://127.0.0.1:$port_num"
    echo "$(tput setaf 2)GET http://127.0.0.1:$port_num/auth.php$(tput sgr0) to fetch a capability token for your iOS/Android app"
    php -S 127.0.0.1:$port_num
}

function start_ngrok() {
    ngrok -subdomain=$subdomain $port_num
}

main $@
