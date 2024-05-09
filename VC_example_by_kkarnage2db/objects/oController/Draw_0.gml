/// @description Draw event
//Draw header text
draw_text(25,25,display_text);

//Draw debug info

//Draw for Client
if (voice_client == true)
{
	//draw mic info
	draw_text(25,60,"mic_id: "+string(mic_id));
	draw_text(25,90,"mic_set: "+string(mic_set));
	draw_text(25,120,"Push to talk key: "+string(chr(pushToTalkKey)));
	draw_text(25,150,"Press number key to change mic:");
	//draw microphones list
	for(var i = 0; i < number_of_mics; i++)
	{
		draw_text(25,150+(i+1)*30,string(i)+" - " + get_mic_name(i));
	}	
	
	//draw users
	draw_text(650,340,"Online users:");
	var i = 0;
	for(var k = ds_map_find_first(voice_chat_users_dsmap); !is_undefined(k); k = ds_map_find_next(voice_chat_users_dsmap,k))
	{	
		i ++;
		draw_text_transformed_color(650,350+25*i,voice_chat_users_dsmap[? k][? "username"] +"(" + string(k) + ") " +string(voice_chat_users_dsmap[? k][? "mic_on"]),1,1,0,c_aqua,c_aqua,c_white,c_lime,1);	
	}
}

//Draw for Server
if (voice_server == true)
{
	//draw all users
	draw_text(650,340,"Online users:");
	var i = 0;
	for(var k = ds_map_find_first(global.server_voice_users); !is_undefined(k); k = ds_map_find_next(global.server_voice_users,k))
	{	
		i ++;
		draw_text_transformed_color(650,350+25*i,global.server_voice_users[? k][? "username"] +"(" + string(k) + ") " +string(global.server_voice_users[? k][? "mic_on"]),1,1,0,c_aqua,c_aqua,c_white,c_lime,1);	
	}
}




