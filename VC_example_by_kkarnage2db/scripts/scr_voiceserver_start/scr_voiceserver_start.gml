function scr_voiceserver_start()
{
	if (voice_server_started >= 0) 
	{
		//create ds map to store connected users information
		global.server_voice_users = ds_map_create();
		
		voice_server = true;
		display_text = "Voice chat Server";
		
		voice_packet_fragmented = array_create(1000,0);
		voice_fragment_buffer = array_create(1000,0);
		voice_tmp_buffer = array_create(1000,0);
		voice_send_buffer = array_create(1000,0);
		voice_write_buffer = array_create(1000,0);
		voice_header_buffer = array_create(1000,0);
	}

}