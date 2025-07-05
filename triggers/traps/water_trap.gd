@tool
class_name WaterTrap
extends Trigger


@export var buffer: float = 28
@export var size: Vector2:
	set(value):
		size = value
		if has_node("CollisionShape2D"):
			var collision: CollisionShape2D = get_node("CollisionShape2D")
			collision.shape = collision.shape.duplicate()
			collision.shape.size = value - Vector2(buffer, buffer)
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	var collision: CollisionShape2D = get_node("CollisionShape2D")
	collision.shape = collision.shape.duplicate()
	collision.shape.size = size - Vector2(buffer, buffer)

func activate() -> void:
	Game.state = Game.State.DEATH
	Achievements.add(Achievements.Type.DROWNING)
	audio.play()


func _on_body_entered(actor: Actor):
	if actor.isPlayer:
		Death.active = Death.Type.DROWN
		activate()
