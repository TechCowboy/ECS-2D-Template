extends Control
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var timer: Timer = %Timer
@onready var score: RichTextLabel = %Score

@export var max_progress_bar:float = 12.0
@export var seconds_max:float = 12.0
@export var timer_tick:float = 0.1

var timer_value:float

const green:Color 	= Color(0x44, 0x9f, 0x47)
const yellow:Color 	= Color(0xd5, 0xfc, 0x47)
const red:Color		= Color(0xff, 0x00, 0x00)
const white:Color 	= Color(0xff, 0xff, 0xff)

var progress_style = null


func _ready() -> void:

	progress_style = get_theme_stylebox("fill").duplicate()
	add_theme_stylebox_override("fill", progress_style)
	progress_style.bg_color = white
	
	
	score.text 				= "Score: 0"
	Globals.score_signal.connect(on_score_updated)
	
	progress_bar.max_value 	= max_progress_bar
	progress_bar.min_value 	= 0.0
	progress_bar.step       = timer_tick
	progress_bar.value     	= max_progress_bar
	
	
	timer.one_shot  		= false
	timer.autostart 		= true
	timer.wait_time 		= timer_tick
	timer_value = seconds_max
	
	timer.start()
	
func _on_timer_timeout() -> void:
	timer_value -= timer_tick
	progress_bar.value = timer_value
	
	if (progress_bar.value <= max_progress_bar / 4.0):
		if  progress_style.bg_color == yellow:
			progress_style.bg_color = red
	else:
		if progress_bar.value <= max_progress_bar / 2.0:
			if (progress_style.bg_color == Color(green)):
				progress_style.bg_color = Color(yellow)
	
	if progress_bar.value <= 0.0:
		Globals.game_over_signal.emit()
		
func on_score_updated(score_text):
	score.text = score_text
	

	
