extends Node2D

@export var texture: Texture2D
@export var tile_size: Vector2 = Vector2(256, 256)
@export var grid_size: Vector2i = Vector2i(4, 4)

var tiles: Array[Sprite2D] = []

func _ready() -> void:
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			var tile: Sprite2D = Sprite2D.new()
			tile.texture = texture
			tile.position = Vector2(x * tile_size.x, y * tile_size.y)
			add_child(tile)
			tiles.append(tile)

func _process(_delta: float) -> void:
	var camera := get_viewport().get_camera_2d()
	if camera == null:
		return

	var cam_pos: Vector2 = camera.global_position
	var base_x: float = floor(cam_pos.x / tile_size.x) * tile_size.x
	var base_y: float = floor(cam_pos.y / tile_size.y) * tile_size.y

	var index: int = 0
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			var tile: Sprite2D = tiles[index]
			tile.position = Vector2(
				base_x + x * tile_size.x,
				base_y + y * tile_size.y
			)
			index += 1
