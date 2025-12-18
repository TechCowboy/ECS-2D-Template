class_name Coin extends AnimatedSprite2D

# Gold
# Frankincense
# Myrrh

func _on_coin_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.items_collected_signal.emit(1)
		
		queue_free()
		
		
