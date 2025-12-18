extends CenterContainer

var previous_master_volume
var previous_music_volume
var previous_sfx_volume
var previous_splash_volume

var master_bus_index
var music_bus_index
var sfx_bus_index
var splash_bus_index

@onready var music_audio_stream_player:  AudioStreamPlayer = %MusicAudioStreamPlayer
@onready var sfx_audio_stream_player:    AudioStreamPlayer = %SFXAudioStreamPlayer
@onready var splash_audio_stream_player: AudioStreamPlayer = %SplashAudioStreamPlayer

@onready var master_volume_h_slider: 		HSlider = %MasterVolumeHSlider
@onready var music_volume_h_slider:         HSlider = %MusicVolumeHSlider
@onready var sound_effects_volume_h_slider: HSlider = %SoundEffectsVolumeHSlider
@onready var splash_volume_h_slider: 		HSlider = %SplashVolumeHSlider



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master_bus_index 	= AudioServer.get_bus_index("Master")
	music_bus_index 	= AudioServer.get_bus_index("Music")
	sfx_bus_index 		= AudioServer.get_bus_index("SFX")
	splash_bus_index 	= AudioServer.get_bus_index("Splash")
	
	GameSettings.read_settings()
	
	Globals.am.change_background_music.emit("")
	
	set_buttons()
			

func set_buttons() -> void:
	
	AudioServer.set_bus_volume_linear(master_bus_index, GameSettings.get_setting(GameSettings.SOUND_KEY_MASTER))
	AudioServer.set_bus_volume_linear(music_bus_index, 	GameSettings.get_setting(GameSettings.SOUND_KEY_MUSIC))
	AudioServer.set_bus_volume_linear(sfx_bus_index,	GameSettings.get_setting(GameSettings.SOUND_KEY_SFX))
	AudioServer.set_bus_volume_linear(splash_bus_index, GameSettings.get_setting(GameSettings.SOUND_KEY_SPLASH))

	previous_master_volume 	= AudioServer.get_bus_volume_linear(master_bus_index)
	previous_music_volume 	= AudioServer.get_bus_volume_linear(music_bus_index)
	previous_sfx_volume 	= AudioServer.get_bus_volume_linear(sfx_bus_index)
	previous_splash_volume 	= AudioServer.get_bus_volume_linear(splash_bus_index)
	
	%MasterVolumeHSlider.value 			= previous_master_volume
	%MusicVolumeHSlider.value 			= previous_music_volume
	%SoundEffectsVolumeHSlider.value 	= previous_sfx_volume
	%SplashVolumeHSlider.value 			= previous_splash_volume
	
	
func _on_save_button_pressed() -> void:
	
	previous_master_volume 	= AudioServer.get_bus_volume_linear(master_bus_index)
	previous_music_volume 	= AudioServer.get_bus_volume_linear(music_bus_index)
	previous_sfx_volume 	= AudioServer.get_bus_volume_linear(sfx_bus_index)
	previous_splash_volume 	= AudioServer.get_bus_volume_linear(splash_bus_index)
	
	
	GameSettings.set_setting(GameSettings.SOUND_KEY_MASTER,	previous_master_volume)
	GameSettings.set_setting(GameSettings.SOUND_KEY_MUSIC, 	previous_music_volume)
	GameSettings.set_setting(GameSettings.SOUND_KEY_SFX, 	previous_sfx_volume)
	GameSettings.set_setting(GameSettings.SOUND_KEY_SPLASH, previous_splash_volume)
	
	GameSettings.save_settings()


func _on_previous_button_pressed() -> void:
	sfx_audio_stream_player.stop()
	
	master_volume_h_slider.value  		= previous_master_volume	
	music_volume_h_slider.value			= previous_music_volume
	splash_volume_h_slider.value 		= previous_sfx_volume
	splash_volume_h_slider.value 		= previous_splash_volume
	
	Globals.sm.change_scene.emit(Globals.game_main_menu_scene)
	

func _on_master_volume_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(master_bus_index, value)

func _on_music_volume_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(music_bus_index, value)
	
func _on_sound_effects_volume_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(sfx_bus_index, value)

func _on_splash_volume_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(splash_bus_index, value)
	

func _on_factory_reset_button_pressed() -> void:
	GameSettings.factory_reset()
	set_buttons()
	
func _on_music_audio_stream_player_finished() -> void:
	music_audio_stream_player.play()

func _on_sfx_audio_stream_player_finished() -> void:
	sfx_audio_stream_player.play()

func _on_splash_audio_stream_player_finished() -> void:
	splash_audio_stream_player.play()
	
func _on_master_volume_h_slider_drag_started() -> void:
	sfx_audio_stream_player.play()
	sfx_audio_stream_player.stream_paused = false
	music_audio_stream_player.play()
	music_audio_stream_player.stream_paused = false
	splash_audio_stream_player.play()
	splash_audio_stream_player.stream_paused = false



func _on_master_volume_h_slider_drag_ended(_value_changed: bool) -> void:
	sfx_audio_stream_player.stream_paused = true
	music_audio_stream_player.stream_paused = true
	splash_audio_stream_player.stream_paused = true


func _on_music_volume_h_slider_drag_started() -> void:
	sfx_audio_stream_player.stream_paused = true
	music_audio_stream_player.stream_paused = false
	music_audio_stream_player.play()
	splash_audio_stream_player.stream_paused = true


func _on_music_volume_h_slider_drag_ended(_value_changed: bool) -> void:
	sfx_audio_stream_player.stream_paused = true
	music_audio_stream_player.stream_paused = true
	splash_audio_stream_player.stream_paused = true


func _on_sound_effects_volume_h_slider_drag_started() -> void:
	sfx_audio_stream_player.stream_paused = false
	sfx_audio_stream_player.play()
	music_audio_stream_player.stream_paused = true
	splash_audio_stream_player.stream_paused = true



func _on_sound_effects_volume_h_slider_drag_ended(_value_changed: bool) -> void:
	sfx_audio_stream_player.stream_paused = true
	music_audio_stream_player.stream_paused = true
	splash_audio_stream_player.stream_paused = true


func _on_splash_volume_h_slider_drag_started() -> void:
	splash_audio_stream_player.stream_paused = false
	splash_audio_stream_player.play()
	music_audio_stream_player.stream_paused = true
	sfx_audio_stream_player.stream_paused = true


func _on_splash_volume_h_slider_drag_ended(_value_changed: bool) -> void:
	sfx_audio_stream_player.stream_paused = true
	music_audio_stream_player.stream_paused = true
	splash_audio_stream_player.stream_paused = true
