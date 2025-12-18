extends Node2D




func _on_death_area_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(Globals.game_over_scene)
