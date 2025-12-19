extends Node

var am = AudioManager.new()
var sm = SceneManager.new()

@warning_ignore("unused_signal") 
signal game_over_signal()

@warning_ignore("unused_signal") 
signal items_collected_signal(item_value)

@warning_ignore("unused_signal") 
signal score_signal(score_text)

# Scenes

const game_splash_scene			= "uid://cyt51meeshfkj"
const game_main_menu_scene		= "uid://c34ymwyxfdewd"
const game_start_scene 			= "uid://bw2n85403ll4k"
const game_over_scene 			= "uid://h6x55wwner7e"
const game_win_scene  			= "uid://dcnh1n4nu4ggb"
const game_settings_scene 		= "uid://bjgq2x8wiyyqw"
const game_help_scene			= "uid://xmboejl36pyl"
const game_credit_scene			= "uid://dwl22b5yqxexb"

# Music

const music_main_menu			= "uid://d3npg8trhgao"
const music_gameplay  			= "uid://c25hggegspgmi"

# Sound Effects

const sfx_item_collected 		= "uid://bdfstjg2cqtsn"

# Splash screen

const splash_intro				= "uid://dqluhst2ljuf4"
const items_needed = 12

var items_collected = 0
