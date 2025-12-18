extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_2d_pressed() -> void:
	get_tree().change_scene_to_file("uid://b6awd18dx6oly")


func _on_button_3d_pressed() -> void:
	get_tree().change_scene_to_file("uid://emptih8rgu2c")
