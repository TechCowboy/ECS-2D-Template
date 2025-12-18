

class_name Maze extends MazeRoom

var my_maze: 	Array[MazeRoom] = []
var unvisited_stack = []
var unvisted_neighbours: Array = []
var visited_stack: Array = []
var rows = 0
var cols = 0

signal generation_complete

var tile_map_layer: TileMapLayer 
 
func index(x:int, y:int):
	return (cols * y + x)
		
func _init() -> void:
	pass


func set_tile_map_layer(tile):
	tile_map_layer = tile
	
func clear(_cols, _rows) -> void:

	cols = _cols
	rows = _rows
	my_maze.resize(rows*cols)
		
	# make all the rooms
	for _row in range(rows):
		for _col in range(cols):
			var room1 : MazeRoom = MazeRoom.new()
			my_maze[index(_col, _row)] = room1
			


func get_neighbours(_col, _row):
	
	unvisted_neighbours = []
		# Determine neighbours of each cell
	if _col-1 >= 0:
		if ! my_maze[index(_col-1, _row)].visited:
			unvisted_neighbours.push_front([_col-1, _row])

	if _col+1 <= cols-1:
		if ! my_maze[index(_col+1, _row)].visited:
			unvisted_neighbours.push_front([_col+1, _row])
		
	if _row-1 >= 0:
		if ! my_maze[index(_col, _row-1)].visited:
			unvisted_neighbours.push_front([_col, _row-1])
		
	if _row+1 <= rows-1:
		if ! my_maze[index(_col, _row+1)].visited:
			unvisted_neighbours.push_front([_col, _row+1])
			
	unvisted_neighbours.shuffle()
	return unvisted_neighbours

func do_nothing():
	pass
	

			
func generate(start_col, start_row, _cols = 12, _rows=12, callable_func: Callable = do_nothing) -> bool:
	var col = start_col
	var row = start_row
	var new_col
	var new_row
	var old_position
		
	clear(_cols, _rows)

	for y in range(rows):
		for x in range(cols):
			unvisited_stack.push_front([x,y])
			
	callable_func.call()
		
	my_maze[index(col,row)].visited = true
	visited_stack.push_front([col,row])
	
	# get next position
	while len(unvisited_stack)>0:
		
		var adjacents = get_neighbours(col, row)
		if adjacents == []:
			old_position = visited_stack.pop_back()
			if old_position == null:
				break
			col = old_position[0]
			row = old_position[1]
			continue
			
		for new_position in adjacents:
			
			new_col = new_position[0]
			new_row = new_position[1]
					
			unvisited_stack.erase(new_position)
			visited_stack.push_front(new_position)
			my_maze[index(new_col, new_row)].visited = true
			
			# remove the walls
			# west wall?
			if new_col == col-1:
				my_maze[index(col, row)].west = false
				my_maze[index(new_col, new_row)].east = false
			else:
				# east wall?
				if new_col == col+1:
					my_maze[index(col, row)].east = false
					my_maze[index(new_col, new_row)].west = false
				else:
					# north wall?
					if new_row == row-1:
						my_maze[index(col, row)].north = false	
						my_maze[index(new_col, new_row)].south = false
					else:
						# south wall
						if new_row == row+1:
							my_maze[index(col, row)].south = false	
							my_maze[index(new_col, new_row)].north = false	
				

		col = new_col
		row = new_row
	
	generation_complete.emit()
		
	return true
	
func get_room(col, row) -> MazeRoom:
	return my_maze[index(col, row)]
	
func display_maze(col=-1, row=-1) -> void:	
	for _row in range(rows):
		for t in range(3):
			var temp:String = ""

			for _col in range(cols):

				var i = _row*cols + _col

				match(t):
					0:
						if my_maze[i].north:
							temp += " --- "
						else:
							temp += "     "

					1:
						if my_maze[i].west:
							temp += "|"
						else:
							temp += " "
							
						if _col == col and _row == row:
							temp += "*"
						else:
							temp += " "
							
						if my_maze[i].visited:
							temp += "V"
						else:
							temp += " "
							
						if my_maze[i].east:
							temp += " |"
						else:
							temp += "  "
					2:

						if my_maze[i].south:
							temp += " ___ "
						else:
							temp += "     "
		
				
			print(temp)
	
	print("___________________________________________")	



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


func draw_maze2():
	var my_room
	
	tile_map_layer.clear()
	
	for row in range(rows):
		for col in range(cols):
			my_room = get_room(col,row)
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

								
