class_name AudioManager extends Node2D

var current_background_music:AudioStream
var current_background_music_file:String = ""

signal change_background_music(music)

@onready var background_music: AudioStreamPlayer2D = $BackgroundMusic
@onready var sfx: AudioStreamPlayer2D = $SFX
@onready var splash: AudioStreamPlayer2D = $Splash

func _init() -> void:
	background_music = AudioStreamPlayer2D.new()
	change_background_music.connect(on_change_background_music)

func set_background_music(bgm:AudioStreamPlayer2D):
	background_music = bgm

func on_change_background_music(music):
	
	if music == "":
		background_music.stream_paused = true
		background_music.playing = false
		background_music.autoplay= false
		current_background_music_file = ""
		return
		
	if music == current_background_music_file:
		return
		
	current_background_music_file = music
	
	current_background_music = load(music)

	background_music.stream = current_background_music
	background_music.stream.loop = true
	background_music.playing = true
	background_music.autoplay = true


	
	
