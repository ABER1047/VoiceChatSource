/// @description Init variables

//general variables
voice_client = false; //applcation is set as client
voice_server = false; //applcation is set as server
display_text = "Press 'C' to start a voice client \n Press 'S' to start a voice server"; //text displayed

//network variables (used both in client and server)
server_ip = "127.0.0.1";
server_port = 32623;



global.is_server = -4;
server = -4;

mic_set = false; // wether a microphone is selected or not
mic_id = 0; //id of the selected microphone
mic_on = false; //recording voice or not

number_of_mics = audio_get_recorder_count();
record_info = array_create(number_of_mics, 0);
mic_names = array_create(number_of_mics, "");
show_debug_message("number of mics : " +string(number_of_mics));

pushToTalkKey = ord("V"); //key used to record voice on press

voice_chat_users_dsmap = ds_map_create();

randomize();
	
username = "user_"+string(irandom(99999));
my_voice_id = -1;
	
audioQueue = array_create(1000, -1);
	
connected_to_voice_server = false;