<?php
require 'vendor/autoload.php';
header('Content-Type: text/xml');

$from     = $_REQUEST['From'];
$callee   = $_REQUEST['callee'];
$callerId = $_REQUEST['callerId'];
$digits   = $_REQUEST['Digits'];

# user chose their callee using <Gather>
if (isset($digits) && !$callee) {
    $callee = $_REQUEST[$digits];
}

$response = new Services_Twilio_Twiml();

if ($callee) {
    $response->dial($callee, array('callerId'=>$callerId));
} else if (preg_match("/^[\d\(\)\-\+ ]+$/", $from)) {
    $contents = @file_get_contents('clients.txt');
    $lines = array_slice(array_filter(explode(',', $contents)), 0, 10);
    if (!$contents) {
        $response->dial('default', array('callerId'=>$callerId));
    } else if (count($lines) == 1) {
        $response->dial($lines[0], array('callerId'=>$callerId));
    } else {
        # Since we don't know (from the Request params) whom a
        # regular PSTN phone wants to call, let them choose
        $options = $lines;
        array_walk($options, function(&$elt, $idx){ $elt = "$idx to call $elt"; });
        $say = 'Press ' . implode(', ', $options) . '.';
        $here = pathinfo(__FILE__, PATHINFO_BASENAME);
        $gather = $response->gather(array('action'=>"/{$here}?".http_build_query($lines),
                                          'numDigits'=>'1'));
        $gather->say($say, array('voice'=>'woman'));
    }
} else {
    $response->say('Congratulations! You just made a call using Twilio Client! That is awesome!', 
                   array('voice'=>'woman'));
}
print $response;
?>
