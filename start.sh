#!/bin/bash

script_name="auth.php"

function main() {
	inject_credentials
	start_server
}

function inject_credentials() {
	if grep REPLACE_WITH_ $script_name > /dev/null; then
		echo "What is your twilio account sid?"
		read account_sid

		echo "What is your auth token?"
		read auth_token

		echo "What is your TwiML app sid?"
		read app_sid

		sed -i '' s/REPLACE_WITH_ACCOUNT_SID/$account_sid/ $script_name
		sed -i '' s/REPLACE_WITH_AUTH_TOKEN/$auth_token/   $script_name
		sed -i '' s/REPLACE_WITH_APP_SID/$app_sid/         $script_name
	fi
}

function start_server() {
	echo "starting php server on http://localhost:5000"
	echo "$(tput setaf 2)GET http://localhost:5000/auth.php$(tput sgr0) to fetch a capability token for your iOS/Android app"
	php -S localhost:5000
}

main
