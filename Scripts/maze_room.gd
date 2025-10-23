class_name MazeRoom extends Node

var north : bool = true
var south : bool = true
var east  : bool = true
var west  : bool = true

var neighbours = []
var visited : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Maze Room")
	pass # Replace with function body.
