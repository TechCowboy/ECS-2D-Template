class_name AudioManager extends Node2D

var current_background_music:AudioStream = null
var current_background_music_file:String = ""
var current_sfx:AudioStream              = null

var master_bus_index
var music_bus_index
var sfx_bus_index
var splash_bus_index

const SOUND_KEY_MASTER	= "Master"
const SOUND_KEY_MUSIC	= "Music"
const SOUND_KEY_SFX		= "SFX"
const SOUND_KEY_SPLASH  = "Splash"

signal play_music(music)
signal play_sfx(sound)
signal sfx_finished()

var _music:  AudioStreamPlayer 	= null
var _sfx:    AudioStreamPlayer 	= null
var _splash: AudioStreamPlayer 	= null


func _init() -> void:
	master_bus_index 	= AudioServer.get_bus_index("Master")
	music_bus_index 	= AudioServer.get_bus_index("Music")
	sfx_bus_index 		= AudioServer.get_bus_index("SFX")
	splash_bus_index 	= AudioServer.get_bus_index("Splash")
	
	play_music.connect(on_change_music)
	play_sfx.connect(on_sfx)
	
func set_music_player(music_player:AudioStreamPlayer):
	_music = music_player
	_music.bus = SOUND_KEY_MUSIC
	
func set_SFX_player(sfx_player:AudioStreamPlayer):
	_sfx = sfx_player
	_sfx.bus = SOUND_KEY_SFX
	_sfx.finished.connect(on_sfx_finished)
	
func set_splash_player(splash_player:AudioStreamPlayer):
	_splash = splash_player
	_splash.bus = SOUND_KEY_SPLASH
	
func set_master_volume(value):
	AudioServer.set_bus_volume_linear(master_bus_index, value)
	
func set_music_volume(value):
	AudioServer.set_bus_volume_linear(music_bus_index, value)
	
func set_SFX_volume(value):
	AudioServer.set_bus_volume_linear(sfx_bus_index, value)
	
func set_splash_volume(value):
	AudioServer.set_bus_volume_linear(splash_bus_index, value)
		
func on_change_music(new_music):
	
	if new_music == "":
		_music.stream_paused = true
		_music.playing = false
		_music.autoplay= false
		current_background_music_file = ""
		return
		
	if new_music == current_background_music_file:
		return
		
	current_background_music_file = new_music
	
	current_background_music = load(new_music)

	_music.stream = current_background_music
	_music.stream.loop = true
	_music.playing = true
	_music.autoplay = true


func on_sfx(new_sfx):

	if new_sfx == "":
		_sfx.stream_paused = true
		_sfx.playing = false
		_sfx.autoplay= false
		return
				
	current_sfx = load(new_sfx)

	_sfx.stream = current_sfx
	_sfx.stream.loop = false
	_sfx.playing = true
	_sfx.autoplay = true
	
func on_sfx_finished():
	sfx_finished.emit()


	
	
