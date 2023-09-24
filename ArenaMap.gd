extends TileMap

var collision_shape: CollisionShape2D

func _ready():
	var level_width = 80
	var level_height = 40
	generate_level(level_width, level_height)

	
func is_loc_of_object(node, x, y):
	var node_loc = local_to_map(node.get_global_position())
	var distance = Vector2(node_loc.x, node_loc.y).distance_to(Vector2(x, y))
	if x == node_loc.x and y == node_loc.y:
		return true
	elif distance < 5:
		return true
	else:
		return false
		
func generate_level(level_width, level_height):

	# Clear existing tiles
	clear()
	
	var sprite_row = 1
	
	var left_wall = Vector2i(8, sprite_row)
	var bottom_wall = Vector2i(9, sprite_row)
	var right_wall = Vector2i(10, sprite_row)
	var top_wall = Vector2i(11, sprite_row)
	var obstacle_1 = Vector2i(12,sprite_row)
	var obstacle_2 = Vector2i(13,sprite_row)
	var obstacle_3 = Vector2i(14,sprite_row)
	var obstacle_4 = Vector2i(15,sprite_row)
	
	# Generate ground
	for x in range(level_width):
		for y in range(level_height):
			var floor_tile = Vector2i(1, sprite_row)
			set_cell(0, Vector2i(x, y), 1, floor_tile)

	# Generate walls (top and sides)
	for x in range(level_width):
		set_cell(1, Vector2i(x, 0), 1, bottom_wall)
		set_cell(1, Vector2i(x, level_height - 1), 1, top_wall)

	for y in range(level_height):
		set_cell(1, Vector2i(0, y), 1, left_wall)
		set_cell(1, Vector2i(level_width - 1, y), 1, right_wall)
		
	# Set corners
	set_cell(1, Vector2i(0,0), 1, Vector2i(4, sprite_row))
	set_cell(1, Vector2i(0, level_height-1), 1, Vector2i(7, sprite_row))
	set_cell(1, Vector2i(level_width-1, 0), 1, Vector2i(5, sprite_row))
	set_cell(1, Vector2i(level_width-1, level_height-1), 1, Vector2i(6, sprite_row))
