## The SceneManager class provides an easy mechanism
## to swap/load scenes during game play without worrying
## about freeing resources
## [br][br]
## Click on SceneManager above to see all documentation
## [br][br]
## Usage Example
## [br]
## [code]
## var sm = SceneManager.new()	# in your globals file
## [/code]
## [br]
## [code]
## Globals.sm.set_scene_folder(%CurrentScene)
## Globals.sm.change_scene.emit(Globals.game_splash_scene)
## [/code]
## [br]

class_name SceneManager extends Node2D

## Change to a new scene, free/release resources from the
## previous scene if appliable
signal change_scene(new_scene:String)

## @experimental Pause the program
signal pause_program()

## @experimental Resume the program
signal resume_program()

var _old_scene:String = ""
var _old_scene_instance = null

var _scene: Node2D = null

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	change_scene.connect(_on_change_scene)
	pause_program.connect(_on_pause_scene)
	resume_program.connect(_on_resume_scene)
	
## sets the Node2D that new scenes will be added and removed from
func set_scene_folder(folder:Node2D):
	_scene = folder

func _on_pause_scene():
	_scene.process_mode = Node.PROCESS_MODE_DISABLED
	
func _on_resume_scene():
	_scene.process_mode = Node.PROCESS_MODE_INHERIT

func _on_change_scene(new_scene:String):	
	if _old_scene_instance != null:
		_old_scene_instance.queue_free()
		
	if new_scene != "":
		var loaded_scene = load(new_scene)
		
		if loaded_scene == null:
			_old_scene = ""
			_old_scene_instance = null
			return
						
		var scene_instance = loaded_scene.instantiate()

		_scene.add_child(scene_instance)
		_old_scene = new_scene
		_old_scene_instance = scene_instance
	else:

		if _old_scene_instance != null:
			_old_scene_instance.queue_free()
			
		_old_scene = ""
		
