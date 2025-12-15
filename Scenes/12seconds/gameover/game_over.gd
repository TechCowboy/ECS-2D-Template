extends Node2D



func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file(Globals.game_start_scene)
