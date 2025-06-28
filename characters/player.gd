class_name Player
extends Node2D


@export var speed: float = 145

@onready var actor: Actor = $Actor

var isFrozen: bool


func _physics_process(delta) -> void:
	# take control from user
	if isFrozen:
		return
	
	var direction = InputHandler.get_direction()
	
	actor.animate(direction, delta)
	if (direction != Vector2.ZERO && !isFrozen):
		actor.move(direction * speed * delta)


func reset(pos: Vector2) -> void:
	actor.global_position = pos
	actor.rotation = 0.0
	visible = true
	isFrozen = false


func get_actor_position() -> Vector2:
	return actor.global_position
