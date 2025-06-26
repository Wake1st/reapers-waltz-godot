class_name Player
extends Node2D


@export var speed: float = 125

@onready var actor: Actor = $Actor


func _physics_process(delta) -> void:
	var direction = InputHandler.get_direction()
	
	actor.animate(direction, delta)
	if (direction != Vector2.ZERO):
		actor.move(direction * speed * delta)
