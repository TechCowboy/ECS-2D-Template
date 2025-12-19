extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	Globals.am.set_music_player(%Music)
	Globals.am.set_SFX_player(%Sfx)
	Globals.am.set_splash_player(%Splash)
	

	Globals.sm.set_scene_folder(%CurrentScene)
	Globals.sm.change_scene.emit(Globals.game_splash_scene)
