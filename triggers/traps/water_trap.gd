class_name WaterTrap
extends Trigger


@export var size: Vector2:
	set(value):
		size = value
		if has_node("CollisionShape2D"):
			get_node("CollisionShape2D").shape.size = value
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D


func activate() -> void:
	Game.state = Game.State.DEATH
	Achievements.add(Achievements.Type.DROWNING)
	audio.play()


func _on_body_entered(actor: Actor):
	if actor.isPlayer:
		Death.active = Death.Type.DROWN
		activate()
