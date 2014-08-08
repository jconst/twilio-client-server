Twilio Token Server
===================

Get all the necessary server-side junk for Twilio Client set up quickly and easily using this simple php server.


Prerequisites
-------------
Make sure you have [created a Twilio account](https://www.twilio.com/try-twilio) and [a TwiML application](https://www.twilio.com/user/account/apps/) to handle your call.

Usage
-----
To deploy using [Heroku](https://heroku.com/), just click here:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

Then, in the app's settings, create the config vars `ACCOUNT_SID`, `AUTH_TOKEN`, `APP_SID` and set them to their corresponding values from your Twilio account.

Or, if you prefer, you can also test using [ngrok](https://ngrok.com/). Just create an ngrok account & install it, then clone this repo and run `./start.sh any-subdomain-you-want`. The script will take you through the process.

####WARNING####
This is just a template aimed at mobile developers who want to get started using Twilio client without having to worry about setting up a server *right away*. If you put this code (unchanged) on your production server, someone **will** end up using your tokens in their own apps for free Twilio calls, charged to your account. In production, you should always ensure that your capability token server is securely protected.
