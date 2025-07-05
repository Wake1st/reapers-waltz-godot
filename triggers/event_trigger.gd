class_name EventTrigger
extends Area2D


var triggered: bool


func _on_body_entered(actor: Actor) -> void:
	if actor.isPlayer && !triggered:
		triggered = true
		Game.state = Game.State.FINALE
