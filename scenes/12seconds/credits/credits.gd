extends CanvasLayer


func _on_previous_button_pressed() -> void:
	Globals.sm.change_scene.emit(Globals.game_main_menu_scene)
