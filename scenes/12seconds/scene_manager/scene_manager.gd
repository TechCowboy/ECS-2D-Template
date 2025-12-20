class_name SceneManager extends Node2D

signal change_scene(new_scene)
signal pause_program()
signal resume_program()

var old_scene:String = ""
var old_scene_instance = null

var scene: Node2D = null

var screen_size_width 
var screen_size_height

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	change_scene.connect(on_change_scene)
	pause_program.connect(on_pause_scene)
	resume_program.connect(on_resume_scene)
	screen_size_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	screen_size_height = ProjectSettings.get_setting("display/window/size/viewport_height")
	
func set_scene_folder(folder):
	scene = folder

func on_pause_scene():
	scene.process_mode = Node.PROCESS_MODE_DISABLED
	
func on_resume_scene():
	scene.process_mode = Node.PROCESS_MODE_INHERIT

func on_change_scene(new_scene:String):	
	if old_scene_instance != null:
		old_scene_instance.queue_free()
		
	if new_scene != "":
		var loaded_scene = load(new_scene)
		
		if loaded_scene == null:
			old_scene = ""
			old_scene_instance = null
			return
						
		var scene_instance = loaded_scene.instantiate()

		scene.add_child(scene_instance)
		old_scene = new_scene
		old_scene_instance = scene_instance
	else:

		if old_scene_instance != null:
			old_scene_instance.queue_free()
			
		old_scene = ""
		
