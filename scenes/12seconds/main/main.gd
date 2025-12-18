extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.sm.set_scene_folder(%CurrentScene)
	Globals.sm.change_scene.emit(Globals.game_main_menu_scene)
