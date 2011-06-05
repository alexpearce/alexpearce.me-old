<?php

$servers = array('127.0.0.1', '99.198.122.133', '::1');

if ($_SERVER['REQUEST_METHOD'] == "POST")
{
	$status = '0';
	$msg = 'An unknown error has occured. Please contact alex@alexpearce.me.';
	if (in_array($_SERVER['SERVER_ADDR'], $servers))
	{
		
		require 'class.phpmailer.php';
		
		$name 		= $_POST['name'];
		$mailFrom 	= $_POST['email'];
		$message 	= $_POST['message'];
		
		if ($name !== '' && $message !== '') {
			
			try {
			
				$mail = new PHPMailer(true);
			
				$body				= $message;
				$mail->Subject		= 'Contact Form Message';
			
				$mail->IsSMTP();
				$mail->SMTPAuth		= true;
				$mail->SMTPSecure	= 'ssl';
				$mail->Host			= 'smtp.gmail.com';
				$mail->Port			= 465;
				$mail->Username 	= 'alex@alexpearce.me';
				$mail->Password		= 'new-pin3';
				
				$mail->WordWrap   = 80;
				
				// Who the email should be from, who to reply to, who it goes to
				$mail->SetFrom('contactform@alexpearce.me', 'Contact Form', 0);
				
				$mail->AddReplyTo($mailFrom, $name);
			
				$mail->AddAddress('alex@alexpearce.me', 'Alex Pearce');		
			
				$mail->MsgHTML($body);
			
				$mail->IsHTML(false);
			
				$mail->Send();
				
				$status = '1';
				$msg = 'Thanks! I\'ll get back to you shortly.';
				
			} catch (phpmailerException $e) {
				$msg =  $e->errorMessage();
			}
			
		}
		else
		{
			$msg = 'Please complete all fields.';
		}
	
	}
	else
	{
		$msg = 'Server is not authorized.';
	}
}

if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
	echo json_encode(array('status' => $status, 'message' => $msg));
}