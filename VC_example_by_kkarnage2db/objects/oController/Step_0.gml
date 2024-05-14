//Application is nether initialized as a server nor client:
if (voice_client == false && voice_server == false)
{
	if keyboard_check(ord("C"))
	{
		//Start Application as client
		scr_voiceclient_start();
		
		//connect to server
		network_set_config(network_config_connect_timeout, 3000);
		server = network_create_socket(network_socket_tcp);
	
		
		//////////////////////////////////////////////////////////////////////////
		voice_server_socket = server;
		voice_server_connect = network_connect(voice_server_socket, server_ip, server_port);
	
		if (voice_server_connect < 0)
		{
			//connection failed
			scr_voiceclient_stop();
			exit;
		}
		else
		{
			connected_to_voice_server = true;
			voice_client = true;
			display_text  = "Voice chat Client";
		
			audio_debug(true);
		
			scr_voiceclient_send_userinfo();
		}
	}
	else
	if keyboard_check(ord("S"))
	{
		server = network_create_server(network_socket_tcp, server_port, 1000);
		voice_server_started = server;
		
		//Start Application as client
		scr_voiceserver_start();
	}
}
else
{
	//	voice client step	
	//if (connected_to_voice_server == true)
	//{
		if keyboard_check(pushToTalkKey) 
		{
			if (mic_on == false && mic_set == true)
			{
				mic_on = true;
				record_info[mic_id] = audio_start_recording(mic_id);
				
				//send to server recording has started
				scr_voiceclient_send_userinfo();
			}
		}
		else
		{
			if (mic_on == true)
			{
				mic_on = false;
				
				audio_stop_recording(record_info[mic_id]); 
				
				//send to server recording has stopped
				scr_voiceclient_send_userinfo();
			}
		}
	//}
	
	//change microphone
	for(var i = 0; i < number_of_mics; i++)
	{
		if (keyboard_check(ord(string(i+1))))
		{
			mic_id = i;
			mic_set = true;
		}
	}
}