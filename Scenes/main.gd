extends Node2D
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var timer: Timer = $Timer

var TILE_SIZE = 16
var my_maze : Maze
var my_room : MazeRoom

var cols = 10	
var rows = 10

const OFFSET = 1

var NO_WALLS = Vector2i(0,1)
var WALL_N   = Vector2i(0,0)
var WALL_NW  = Vector2i(1,0)
var WALL_NE  = Vector2i(8,0)
var WALL_NWS = Vector2i(2,0)
var WALL_NWSE= Vector2i(3,0)
var WALL_NWE = Vector2i(3,1)
var WALL_NS  = Vector2i(4,1)
var WALL_NSE = Vector2i(7,1)
var WALL_W   = Vector2i(4,0)
var WALL_WE  = Vector2i(5,1)
var WALL_WS  = Vector2i(1,1)
var WALL_WSE = Vector2i(6,1)
var WALL_S   = Vector2i(5,0)
var WALL_SE  = Vector2i(2,1)
var WALL_E   = Vector2i(6,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	print("Begin at main")
	my_maze = Maze.new()
	my_maze.set_tile_map_layer(tile_map_layer)
	my_maze.generate(0, 0, cols, rows,true, draw_maze)
	print("Drawing...")
	draw_maze()
	print("Drawn")

func get_walls(room:MazeRoom) -> String:
	var walls = ""
	if room.north:
		walls += 'N'
	if room.west:
		walls += 'W'
	if room.south:
		walls += 'S'
	if room.east:
		walls += 'E'
	return walls

func draw_maze():
	
	#print("wait")
	#timer.start()
	#while ! timer.is_stopped():
	#	pass
	#print("wait done.")
	
	#my_maze.display_maze()
	
	tile_map_layer.clear()

	for row in range(my_maze.rows):
		for col in range(my_maze.cols):
			my_room = my_maze.get_room(col,row)
			match(get_walls(my_room)):
				"N":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_N)
				"NW":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_NW)
				"NWE":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_NWE)
				"NE":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_NE)
				"NS":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_NS)
				"NSE":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_NSE)
				"NWS":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_NWS)			
				"NWSE":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_NWSE)		
				"W":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_W)
				"WE":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_WE)
				"WS":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_WS)
				"WSE":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_WSE)
				"S":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_S)	
				"SE":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_SE)	
				"E":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,WALL_E)
				"":
					tile_map_layer.set_cell(Vector2i(col+OFFSET, row+OFFSET),0,NO_WALLS)	
				_:
					print("No graphic: "+get_walls(my_room))
	

				
	
func _on_button_pressed() -> void:
	my_maze.generate(0,0, cols, rows)
	print("Drawing...")
	draw_maze()
	print("Drawn")
