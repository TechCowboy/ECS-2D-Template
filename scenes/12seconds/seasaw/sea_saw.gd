extends Node2D

@onready var timer: Timer = $RotationTimer

var platform_rotation = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	platform_rotation = 0.0

func _on_left_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		platform_rotation = -0.1


func _on_middle_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		platform_rotation = 0.0

func _on_right_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		platform_rotation = 0.1
	
func _on_rotation_timer_timeout() -> void:
	rotate(platform_rotation)
