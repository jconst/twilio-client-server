Twilio Token Server
===================

Get all the necessary server-side junk for Twilio Client set up quickly and easily using this simple php server.


Prerequisites
-------------
Make sure you have [created a Twilio account](https://www.twilio.com/try-twilio) and [a TwiML application](https://www.twilio.com/user/account/apps/) to handle your call.

Usage
-----
Just clone this repo and run `./start.sh`.

The script will ask for your Twilio credentials and start a php server on localhost. Just hit `http://localhost:5000` with a GET request in your iOS/Android app to download a capability token so you can start making calls with Twilio Client!

###Tip###
Since this server will run on localhost by default, you can only make requests to it from a device simulator/emulator on the same machine. To get a temporary, publicly visible address in a couple of minutes, try out [ngrok](https://ngrok.com/). Just run something like `ngrok 5000`.

####WARNING####
This is just a template aimed at mobile developers who want to get started using Twilio client without having to worry about setting up a server *right away*. If you put this code (unchanged) on your production server, someone **will** start using it in their own apps for free Twilio calls, charged to your account. In production, you should always ensure that your capability token server is securely protected.
