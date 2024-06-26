
function scr_voiceserver_handlemessage(buffer, socket)
{
	while(true) 
	{
	    var message_id = buffer_read(buffer,buffer_u8);
		var expected_packet_size = 0;
		
		if (message_id == 99)
		{ 
			//packet with the size information of next packet
			if (buffer_tell(buffer)+4 < buffer_get_size(buffer))
			{ //packet is of the correct size (at least 4bytes)
				expected_packet_size = buffer_read(buffer,buffer_u32); //read expected size of the incoming packet
			}
			else //packet size is incorrect (incomplete packet)
			{
				//add the packet to the voice_fragment_buffer, exit the message handler and wait for the remaining data
				buffer_delete(voice_fragment_buffer[@ socket]);
		        voice_fragment_buffer[@ socket] = buffer_create(buffer_get_size(buffer) - (buffer_tell(buffer)-1), buffer_fixed, 1); //buffer_tell()-1 to put back the message_id into the buffer
		        buffer_copy(buffer,buffer_tell(buffer)-1,buffer_get_size(buffer) - (buffer_tell(buffer)-1),voice_fragment_buffer[@ socket],0);
		        voice_packet_fragmented[@ socket] = true;
	            exit; 
			}
		}
		
		
	    if (buffer_get_size(buffer) - (buffer_tell(buffer) ) < expected_packet_size)
		{ // packet is smaller than the expected size = voice_packet_fragmented packet
			//add the packet to the voice_fragment_buffer, exit the message handler and wait for the remaining data
			buffer_delete(voice_fragment_buffer[@ socket]);
		    voice_fragment_buffer[@ socket] = buffer_create(buffer_get_size(buffer) - (buffer_tell(buffer)-5), buffer_fixed, 1); //buffer_tell()-5 to put back the message_id and size into the buffer
		    buffer_copy(buffer,buffer_tell(buffer)-5,buffer_get_size(buffer) - (buffer_tell(buffer)-5),voice_fragment_buffer[@ socket],0);
			voice_packet_fragmented[@ socket] = true;
		    exit;
	    }

	    switch(message_id)
	    {
			//receive user info from client
			case 3:
				scr_voiceserver_receive_userinfo(buffer, socket);
			break;
			
			//voice message
			case 4:
				scr_voiceserver_receive_audio(buffer, socket);
			break;
		}
		
		if (buffer_tell(buffer) >= buffer_get_size(buffer))
		{
			break;	
		}
	}
}