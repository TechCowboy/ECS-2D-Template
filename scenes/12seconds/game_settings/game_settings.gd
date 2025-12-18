extends Node

var settings:ConfigFile = null

const GAME_SETTINGS_FILE:String = "user://settings.ini"

const VR_SECTION 		= "VR"
const SOUND_SECTION 	= "Sound"
const LANGUAGE_SECTION  = "Language"


const SOUND_KEY_MASTER	= "Master"
const SOUND_KEY_MUSIC	= "Music"
const SOUND_KEY_SFX		= "SFX"
const SOUND_KEY_SPLASH  = "Splash"

const LANGUAGE_KEY      = "Language"

var setting_values = 	{ 	
							LANGUAGE_KEY        : LANGUAGE_SECTION,
							SOUND_KEY_MASTER 	: SOUND_SECTION,
						 	SOUND_KEY_MUSIC 	: SOUND_SECTION,
							SOUND_KEY_SFX 		: SOUND_SECTION,
							SOUND_KEY_SPLASH	: SOUND_SECTION 
						}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings = ConfigFile.new()
	
func default_settings() -> void:
	set_setting(SOUND_KEY_MASTER,	1.0)
	set_setting(SOUND_KEY_MUSIC, 	1.0)
	set_setting(SOUND_KEY_SFX, 		1.0)
	set_setting(SOUND_KEY_SPLASH,   1.0)
	set_setting(LANGUAGE_KEY,       "en")
	
func read_settings() -> void:
	default_settings()
	if FileAccess.file_exists(GAME_SETTINGS_FILE):
		if settings.load(GAME_SETTINGS_FILE) != OK:
			default_settings()


func save_settings() -> void:
	settings.save(GAME_SETTINGS_FILE)

func set_setting(key, value):
	settings.set_value(setting_values[key], key, value)	

func get_setting(key):
	var value = settings.get_value(setting_values[key], key)
	return value	
	
func factory_reset():
	settings.clear()
	default_settings()
