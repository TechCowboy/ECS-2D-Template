extends CanvasLayer


var languages = {
	"English"   : "en",
	"français"  : "fr"
}

@onready var language_options: OptionButton = %Language

func _ready() -> void:
	var keys = languages.keys()
	var selected = -1
	var language_key = "en"
	
	var index = 0
	for l in keys:
		language_options.add_item(l)
		if languages[l]  == language_key:
			selected = index
		index += 1

	if selected != -1:
		TranslationServer.set_locale(languages[keys[selected]])
			
	language_options.selected = selected

	TranslationServer.set_locale(languages[keys[selected]])
	Globals.am.play_music.emit(Globals.music_main_menu)

func _on_start_button_pressed() -> void:
	Globals.sm.change_scene.emit(Globals.game_start_scene)

func _on_language_item_selected(index: int) -> void:
	var keys = languages.keys()
	TranslationServer.set_locale(languages[keys[index]])

func _on_settings_pressed() -> void:
	Globals.sm.change_scene.emit(Globals.game_settings_scene)

func _on_help_button_pressed() -> void:
	Globals.sm.change_scene.emit(Globals.game_help_scene)

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	Globals.sm.change_scene.emit(Globals.game_credit_scene)
