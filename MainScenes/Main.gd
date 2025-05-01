extends Node2D

@onready var background: Sprite2D = %Backgroundincreaseddpi
@onready var camera: Camera2D = $MainCharacter/cameracontroller  # Adjust path to reach player's camera

func _ready():
	set_camera_limits()
	camera.make_current()


func set_camera_limits():
	var texture_size = background.texture.get_size()
	var scale = background.scale
	var bg_position = background.global_position

	var half_width = (texture_size.x * scale.x) / 2
	var half_height = (texture_size.y * scale.y) / 2

	var left = int(bg_position.x - half_width)
	var right = int(bg_position.x + half_width)
	var top = int(bg_position.y - half_height)
	var bottom = int(bg_position.y + half_height)

	camera.limit_left = left
	camera.limit_right = right
	camera.limit_top = top
	camera.limit_bottom = bottom
