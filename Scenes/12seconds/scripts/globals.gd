extends Node

@warning_ignore("unused_signal") 
signal game_over_signal()

@warning_ignore("unused_signal") 
signal items_collected_signal(item_value)

@warning_ignore("unused_signal") 
signal score_signal(score_text)

const game_start_scene = "uid://bw2n85403ll4k"
const game_over_scene = "uid://h6x55wwner7e"
const game_win_scene  = "uid://dcnh1n4nu4ggb"

const items_needed = 12

var items_collected = 0
