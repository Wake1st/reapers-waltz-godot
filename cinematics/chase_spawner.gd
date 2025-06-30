class_name ChaseSpawner
extends Node2D


const ENEMY: PackedScene = preload("res://characters/enemy.tscn")
const INESCAPABLE: float = 5000.0
const SPREAD: float = 96.0

@export var spawn_count: int = 4

var enemies: Array[Enemy]


func _process(_delta) -> void:
	if EventHandler.finalCinematic:
		EventHandler.finalCinematic = false
		spawn()


func check_pursuit(target: Vector2) -> void:
	for enemy in enemies:
		# skip if despawned
		if enemy == null:
			continue
		
		if enemy.in_pursuit():
			if enemy.check_caught(target):
				Game.state = Game.State.DEATH
				despawn()
			elif !enemy.check_pursuit(target):
				enemy.exit_pursuit()
		else:
			enemy.check_pursuit(target)


func spawn() -> void:
	for i in spawn_count:
		var enemy: Enemy = ENEMY.instantiate()
		enemies.push_back(enemy)
		enemy.patrolPoints = [
			global_position + Vector2(
				randf_range(-SPREAD, SPREAD),
				randf_range(-SPREAD, SPREAD)
			),
			global_position + Vector2(INESCAPABLE,0),
		]
		enemy.pursueDistance = INESCAPABLE
		enemy.speed = 160
		add_child(enemy)


func despawn() -> void:
	for enemy in enemies:
		remove_child(enemy)
		enemy.queue_free()
