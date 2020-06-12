extends Node2D

onready var grid = get_parent()


func _ready():
	pass



func _draw():
	var LINE_COLOR = Color(0.3, 0.3, 0.9, .4)
	var LINE_WIDTH = 2
#	var window_size = OS.get_window_size()

	for x in range(grid.grid_size.x + 1):
		var col_pos = x * 20
		var limit = grid.grid_size.y * grid.grid_size.y
		print(x)
		draw_line(Vector2(col_pos, 0), Vector2(col_pos, limit), LINE_COLOR, LINE_WIDTH)
	for y in range(grid.grid_size.y + 1):
		var row_pos = y * 20
		var limit = grid.grid_size.x * grid.grid_size.x
		draw_line(Vector2(0, row_pos), Vector2(limit, row_pos), LINE_COLOR, LINE_WIDTH)
		
	
	
