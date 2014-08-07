<?php
require 'vendor/autoload.php';

header('Content-Type: application/json');

// AccountSid and AuthToken can be found in your account dashboard
$accountSid = 'REPLACE_WITH_ACCOUNT_SID';
$authToken = 'REPLACE_WITH_AUTH_TOKEN';

// The app outgoing connections will use:
$appSid = 'REPLACE_WITH_APP_SID';

// The client name for incoming connections:
$clientName = $_REQUEST['clientName'] ?: 'monkey';

$capability = new Services_Twilio_Capability($accountSid, $authToken);

// This allows incoming connections as $clientName:
$capability->allowClientIncoming($clientName);

// This allows outgoing connections to $appSid with the 'From'
// parameter being the value of $clientName
$capability->allowClientOutgoing($appSid, array(), $clientName);

// This returns a token to use with Twilio based on
// the account and capabilities defined above
$token = $capability->generateToken();

echo json_encode(array('token'=>$token));
?>
