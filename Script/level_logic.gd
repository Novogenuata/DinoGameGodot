extends Node

@export var level: int = 1

@onready var timer = $LevelTimer
@onready var player = $"../MainCharacter"
@onready var enemy_interval = $EnemyInterval
@onready var enemies_left

const slow_slime = preload("res://CharacterScenes/slow_slime.tscn")
const fast_slime = preload("res://CharacterScenes/fast_slime.tscn")
const tank_slime = preload("res://CharacterScenes/tank_slime.tscn")

func _ready():
	timer.start()

func _process(delta: float):
	if timer <= 0:
		timer.stop()
		new_level()

func new_level():
	enemy_interval = 1.2
	enemies_left = 15 * level
	spawn_enemies()
	
func spawn_enemies():
	while enemies_left > 0:
		var enemy_rng = randi_range(1, level)
		match enemy_rng:
			1:
				spawn_slime("slow_slime")
			2:
				spawn_slime("fast_slime")
			3:
				spawn_slime("tank_slime")
		enemy_interval.start()
		await enemy_interval
	level += 1
	timer.start()

func spawn_slime(slime):
	var slime_instance = slime.instantiate()
	get_tree().root.add_child(slime_instance)
	slime_instance.global_position = player.global_position
