extends Node2D




func _on_death_area_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		Globals.sm.change_scene.emit(Globals.game_over_scene)
