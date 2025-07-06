class_name Player
extends Node2D


const FALL: float = 1000
@export var speed: float = 150

@onready var actor: Actor = $Actor
@onready var camera: Camera = %Camera
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var isFrozen: bool


func _physics_process(delta) -> void:
	# take control from user
	if isFrozen || Game.state != Game.State.PLAY:
		return
	
	var direction = InputHandler.get_direction()
	
	actor.animate(direction, delta)
	if (direction != Vector2.ZERO):
		actor.move(direction * speed * delta)
		if !audio.playing:
			audio.play()
	else:
		audio.stop()


func reset(pos: Vector2) -> void:
	actor.global_position = pos
	actor.rotation = 0.0
	actor.z_index = 0
	visible = true
	isFrozen = false
	camera.reparent(actor)
	camera.global_position = pos


func get_actor_position() -> Vector2:
	return actor.global_position


func animate_death() -> void:
	isFrozen = true
	
	match Death.active:
		Death.Type.DROWN, Death.Type.CRUSH:
			visible = false
		Death.Type.SPIKE:
			actor.rotate(randf_range(-PI/5, PI/5))
		Death.Type.FALL:
			camera.reparent(self)
			actor.z_index = -2
			var tween = create_tween()
			tween.tween_property(actor, "position:y", actor.position.y + FALL, 0.8)
