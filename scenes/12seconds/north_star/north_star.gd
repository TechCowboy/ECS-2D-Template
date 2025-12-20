extends Sprite2D

@onready var north_star: Sprite2D = $"."
@onready var player: CharacterBody2D = %Player

var height
var star_starting_x
var player_starting_x
var parallax_x

func _ready() -> void:
	Globals.move_star_up.connect(on_move_star_up)
	height = north_star.position.y
	star_starting_x = north_star.position.x
	parallax_x = star_starting_x
	player_starting_x = player.position.x
	
func _process(delta: float) -> void:
	north_star.position.x = star_starting_x + (player.position.x- player_starting_x) *0.75 
	north_star.position.y = lerpf(north_star.position.y, height, delta)
	
	
func on_move_star_up(amount):
	height += amount
	
