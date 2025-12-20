extends Node2D

func _ready() -> void:
	Globals.am.play_music.emit("")
	Globals.am.play_sfx.emit(Globals.music_gamewon)

func _on_restart_button_pressed() -> void:
	Globals.sm.change_scene.emit(Globals.game_start_scene)
