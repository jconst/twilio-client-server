<?php
header('Content-type: text/xml');

$callee   = $_REQUEST["callee"];
$callerId = $_REQUEST["callerId"];
$cidAttr  = "";
if ($callerId) { 
    $cidAttr = 'callerId="' . $callerId . '"';
}
?>

<Response>
<?php if ($callee) { ?>
    <Dial <?php echo $cidAttr; ?>>
    <?php if (preg_match("/^[\d\(\)\-\+ ]+$/", $callee)) { ?>
        <Number><?php echo $callee;?></Number>
    <?php } else { ?>
        <Client><?php echo $callee;?></Client>
    <?php } ?>
    </Dial>
<?php } else { ?>
    <Say voice="woman">
        Congratulations! You just made a call using Twilio Client! That is awesome!
    </Say>
<?php } ?>
</Response>