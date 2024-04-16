extends Node2D

@onready var tile_map = $TileMap

var rng = RandomNumberGenerator.new()
var random_number : int
var rng_amount = 9 # 0 is the first number
var width = 1000
var height = 10
var source_id = 0
var dark_tile = Vector2i(0, 0)
var light_tile = Vector2i(1, 0)
var void_tile = Vector2i(-1, -1)
var spike = Vector2i(2, 0)
var coin = Vector2i(3, 0)
var coin_amount = 0

func _ready():
	generate()
	print(coin_amount)

func generate():
	tile_map.set_cell(0, Vector2i(0, 0), source_id, light_tile)
	for q in range(height + 10):
		tile_map.set_cell(0, Vector2i(0, q + 1), source_id, dark_tile)
	for x in range(1, width):
		for y in range(height):
			var dark_tile_above = tile_map.get_cell_atlas_coords(0, Vector2i(x, y - 1)) == Vector2i(0, 0)
			var light_tile_above = tile_map.get_cell_atlas_coords(0, Vector2i(x, y - 1)) == Vector2i(1, 0)
			var void_tile_above = tile_map.get_cell_atlas_coords(0, Vector2i(x, y - 1)) == Vector2i(-1, -1)
			rng.randomize()
			random_number = rng.randi_range(rng_amount - rng_amount, rng_amount - 1)

			# Checking the cell above to determin what tile will be placed
			if random_number == 0 or random_number == 3 or random_number == 6: #Default: Dark tile
				#if y >= 5 and tile_map.get_cell_atlas_coords(0, Vector2i(x, y - 4)) == Vector2i(-1, -1) and tile_map.get_cell_atlas_coords(0, Vector2i(x, y - 1)) == Vector2i(-1, -1):
					#tile_map.set_cell(0, Vector2i(x, y), source_id, light_tile)
				if dark_tile_above:
					tile_map.set_cell(0, Vector2i(x, y), source_id, dark_tile)
				elif light_tile_above:
					tile_map.set_cell(0, Vector2i(x, y), source_id, dark_tile)
				elif void_tile_above:
					pass

			elif random_number == 1 or random_number == 4 or random_number == 7: #Default: Light tile
				#if y >= 5 and tile_map.get_cell_atlas_coords(0, Vector2i(x, y - 4)) == Vector2i(-1, -1) and tile_map.get_cell_atlas_coords(0, Vector2i(x, y - 1)) == Vector2i(-1, -1):
					#tile_map.set_cell(0, Vector2i(x, y), source_id, light_tile)
				if dark_tile_above:
					tile_map.set_cell(0, Vector2i(x, y), source_id, dark_tile)
				elif light_tile_above:
					tile_map.set_cell(0, Vector2i(x, y), source_id, dark_tile)
					
				elif void_tile_above:
					tile_map.set_cell(0, Vector2i(x, y), source_id, light_tile)

			elif random_number == 2 or random_number == 5 or random_number == 8: #Default: Void tile
				#if y >= 5 and tile_map.get_cell_atlas_coords(0, Vector2i(x, y - 4)) == Vector2i(-1, -1) and tile_map.get_cell_atlas_coords(0, Vector2i(x, y - 1)) == Vector2i(-1, -1):
					#tile_map.set_cell(0, Vector2i(x, y), source_id, light_tile)
				if dark_tile_above:
					tile_map.set_cell(0, Vector2i(x, y), source_id, dark_tile)
				elif light_tile_above:
					tile_map.set_cell(0, Vector2i(x, y), source_id, dark_tile)
				elif void_tile_above:
					pass

			if tile_map.get_cell_atlas_coords(0, Vector2i(x, y)) == Vector2i(1, 0) and (y >= 5 or y == 3):
				tile_map.set_cell(1, Vector2i(x, y), source_id, spike)
			else:
				pass

			if y == 0 and random_number == 3 and tile_map.get_cell_atlas_coords(0, Vector2i(x, y)) == Vector2i(-1, -1) and not tile_map.get_cell_atlas_coords(0, Vector2i(x - 1, y - 4)) == Vector2i(3, 0) and not tile_map.get_cell_atlas_coords(0, Vector2i(x - 2, y - 4)) == Vector2i(3, 0) and not tile_map.get_cell_atlas_coords(0, Vector2i(x - 3, y - 4)) == Vector2i(3, 0):
				tile_map.set_cell(0, Vector2i(x, y - 4), source_id, coin)
				coin_amount += 1
			elif y == 7 and (random_number == 0 or random_number == 3 or random_number == 5) and not tile_map.get_cell_atlas_coords(0, Vector2i(x - 1, y)) == Vector2i(3, 0) and not tile_map.get_cell_atlas_coords(0, Vector2i(x - 2, y)) == Vector2i(3, 0) and not tile_map.get_cell_atlas_coords(0, Vector2i(x - 3, y)) == Vector2i(3, 0) and tile_map.get_cell_atlas_coords(0, Vector2i(x, y)) == Vector2i(-1, -1):
				tile_map.set_cell(0, Vector2i(x, y), source_id, coin)
				coin_amount += 1
			else:
				pass

	for a in range(10):
		for b in range(1, width):
			if tile_map.get_cell_atlas_coords(0, Vector2i(b, height - 1)) == Vector2i(-1, -1):
				tile_map.set_cell(0, Vector2i(b, height), source_id, light_tile)
				tile_map.set_cell(1, Vector2i(b, height), source_id, spike)
			else:
				tile_map.set_cell(0, Vector2i(b, height), source_id, dark_tile)
			tile_map.set_cell(0, Vector2i(b, height + a + 1), source_id, dark_tile)
