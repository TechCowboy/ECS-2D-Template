extends Node2D


func _on_nyrrh_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.items_collected_signal.emit(1)
		
		queue_free()
