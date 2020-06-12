extends TileMap

onready var lookup = "res://assets/lookup.txt"
onready var pac = get_node("Pacman")

var tile_size = get_cell_size()
var half_tile_size:Vector2 =  Vector2(10,10)
var current = Vector2(-1, 0)
var prev = Vector2(-1, 0)

var grid_size = Vector2(28,36)
var grid = []
var pills = []
var b_pills = []
var dre = Vector2()
var prev_dir
func _ready():
	
	#Initializing Grid
	for x in range(grid_size.x):
		grid.append([])
		for _y in range(grid_size.y):
			grid[x].append(null)
	
	#Map grid according to lookups
	initialize_lookup(lookup)
	pass # Replace with function body.

func _process(delta):
	
	dre = pac.position
	
	pass


func calculate_next_position(child):
	
	var direction:Vector2
	var pos:Vector2
	var _old_grid_pos:Vector2
	var new_grid_pos:Vector2
	var target_pos
	var marg = 14
	match(child.type):
		GLOBALS.ENTITY_TYPES.PLAYER:
			direction = get_direction(child)
			pos = child.position
			#marg*= -1*(direction.x + direction.y)
			
			target_pos = pos + direction
			
			if (grid[world_to_map(target_pos+GLOBALS.LEFT*(marg-4)).x][world_to_map(target_pos).y] == GLOBALS.ENVIR_TYPES.WALL 
			&& direction == GLOBALS.LEFT):
					current =  Vector2() if current == prev else prev 
					target_pos -= direction
					print("blocked left")
			if (grid[world_to_map(target_pos+GLOBALS.RIGHT*(marg-5)).x][world_to_map(target_pos).y] == GLOBALS.ENVIR_TYPES.WALL
				&& direction == GLOBALS.RIGHT):
					current =  Vector2() if current == prev else prev 
					target_pos = pos
					print("blocked right")
			if (grid[world_to_map(target_pos).x][world_to_map(target_pos+GLOBALS.UP*(marg+2)).y] == GLOBALS.ENVIR_TYPES.WALL
				&& direction == GLOBALS.UP):
					current = Vector2() if current == prev else prev 
					target_pos = pos
					print("blocked right")
			if (grid[world_to_map(target_pos).x][world_to_map(target_pos+GLOBALS.DOWN*(marg+2)).y] == GLOBALS.ENVIR_TYPES.WALL
				&& direction == GLOBALS.DOWN):
					current =  Vector2() if current == prev else prev 
					target_pos = pos
					print("blocked right")
			
			
			prev = current
			_old_grid_pos = world_to_map(pos)
			new_grid_pos = world_to_map(target_pos) + direction
			
			
			
			return map_to_world(new_grid_pos) + half_tile_size

func get_direction(child):
	
	if child.type == GLOBALS.ENTITY_TYPES.PLAYER:
		#var x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
		#var y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
		
		if Input.is_action_just_pressed("down"):
			current = GLOBALS.DOWN
		if Input.is_action_just_pressed("left"):
			current = GLOBALS.LEFT
		if Input.is_action_just_pressed("right"):
			current = GLOBALS.RIGHT
		if Input.is_action_just_pressed("up"):
			current = GLOBALS.UP
		
		
		return current




func initialize_lookup(file):

	var f = File.new()
	f.open(file, File.READ)
	var index = 0
	
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		
		for x in range(grid_size.x):
			grid[x][index+3] = parse_lookup(line[x])
			if grid[x][index+3] == GLOBALS.ENVIR_TYPES.PILL:
				pills.append(Vector2(x, index+3))
			elif grid[x][index+3] == GLOBALS.ENVIR_TYPES.B_PILL:
				b_pills.append(Vector2(x, index+3))
		index += 1
	f.close()
	return


func parse_lookup(chr):
	
	match(chr):
		'o':
			return GLOBALS.ENVIR_TYPES.PILL
		'+':
			return null
		'*':
			return GLOBALS.ENVIR_TYPES.B_PILL
		'.':
			return GLOBALS.ENVIR_TYPES.WALL
		_:
			return null

func _draw():
	
	draw_circle(dre+Vector2(10,0), 2, Color.white)
	#To draw pills designated in lookup and every frame
	for p in pills:
		#To check if pill has been eaten
		if grid[p.x][p.y] != GLOBALS.ENVIR_TYPES.PILL:
			continue
		
		var rect:Rect2 = Rect2(map_to_world(p)+half_tile_size-Vector2(2,2), Vector2(5,5))
		draw_rect(rect, Color(0.9, 0.72, 0.69, 1))
	
	for b in b_pills:
		
		if grid[b.x][b.y] != GLOBALS.ENVIR_TYPES.B_PILL:
			continue
		
		draw_circle(map_to_world(b)+half_tile_size, 8, Color(0.9, 0.72, 0.69, 1))
