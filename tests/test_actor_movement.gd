extends Node2D


@export var speed: float = 135

@onready var actor: Actor = $Actor


func _physics_process(delta) -> void:
	var direction = InputHandler.get_direction()
	
	actor.animate(direction, delta)
	if (direction != Vector2.ZERO):
		actor.move(direction * speed * delta)
