class_name Actor
extends Node2D


const FRAME_SPEED: float = 0.15

@export var texture: Texture2D:
	set(value):
		texture = value
		if (has_node("Sprite2D")):
			get_node("Sprite2D").texture = value

@onready var sprite: Sprite2D = $Sprite2D

var frameCounter: float
var isFrozen: bool


func move(vector: Vector2) -> void:
	position += vector


func animate(direction: Vector2, delta: float) -> void:
	# reset animations when still
	if (direction == Vector2.ZERO):
		sprite.frame_coords.x = 0
		frameCounter = 0
		return
	else:
		frameCounter += delta
		if (frameCounter >= FRAME_SPEED):
			frameCounter -= FRAME_SPEED
			sprite.frame_coords.x = (1 + sprite.frame_coords.x) % sprite.hframes
		
		# set animation layer
		if (direction.y > 0.0):
			sprite.frame_coords.y = 0
		elif (direction.y < 0.0):
			sprite.frame_coords.y = 3
		elif (direction.x > 0.0):
			sprite.frame_coords.y = 2
		elif (direction.x < 0.0):
			sprite.frame_coords.y = 1
