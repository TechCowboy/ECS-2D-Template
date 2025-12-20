extends Node2D

@export var items_for_win = Globals.items_needed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.items_collected = 0
	
	Globals.game_over_signal.connect(on_game_over)
	Globals.items_collected_signal.connect(on_item_collected)
	Globals.am.play_music.emit(Globals.music_gameplay)
	

func on_game_over() -> void:
	
	if Globals.items_collected >= items_for_win:
		Globals.sm.change_scene.emit(Globals.game_win_scene)
	else:
		Globals.sm.change_scene.emit(Globals.game_over_scene)
	
	
func on_item_collected(value):
	Globals.items_collected += value
	Globals.score_signal.emit("Score: "+ str(Globals.items_collected))
	
	
