extends Node

@export var level: int = 1

@onready var timer = $LevelTimer
@onready var player = $"../MainCharacter"
@onready var enemy_interval = $EnemyInterval
@onready var enemies_left
@onready var spawnpoints = $spawnpoints

const slow_slime = preload("res://CharacterScenes/slow_slime.tscn")
const fast_slime = preload("res://CharacterScenes/fast_slime.tscn")
const tank_slime = preload("res://CharacterScenes/tank_slime.tscn")

func _ready():
	cooldown()

func _process(delta: float):
	self.global_position = player.global_position

func new_level():
	enemy_interval.wait_time = 1.2
	enemies_left = 2 * level
	spawn_enemies()
	
func spawn_enemies():
	while enemies_left > 0:
		var enemy_rng = randi_range(1, level)
		match enemy_rng:
			1:
				spawn_slime(slow_slime)
			2:
				spawn_slime(fast_slime)
			3:
				spawn_slime(tank_slime)
		enemies_left -= 1
		print(enemies_left)
		enemy_interval.start()
		await enemy_interval.timeout
	level += 1
	cooldown()

func spawn_slime(slime):
	var slime_instance = slime.instantiate()
	get_tree().root.add_child(slime_instance)
	var random_spawn = spawnpoints.get_children()[randi_range(0, 3)]
	slime_instance.global_position = random_spawn.global_position
	
func cooldown():
	timer.start()
	await timer.timeout
	new_level()
