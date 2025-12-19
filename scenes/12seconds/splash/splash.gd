extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.am.play_sfx.emit(Globals.splash_intro)

func _on_splash_timer_timeout() -> void:
	Globals.sm.change_scene.emit(Globals.game_main_menu_scene)
