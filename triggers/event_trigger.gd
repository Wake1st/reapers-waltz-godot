class_name EventTrigger
extends Area2D


enum Type {
	FINALE,
	EXIT
}

@export var type: Type

var triggered: bool


func reset() -> void:
	triggered = false


func _on_body_entered(actor: Actor) -> void:
	if actor.isPlayer && !triggered:
		triggered = true
		match type:
			Type.FINALE:
				Game.state = Game.State.FINALE
			Type.EXIT:
				Game.state = Game.State.OUTRO
