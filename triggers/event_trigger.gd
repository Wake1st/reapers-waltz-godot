class_name EventTrigger
extends Area2D


func _on_body_entered(actor: Actor) -> void:
	if actor.isPlayer:
		EventHandler.finalCinematic = true
		Game.state = Game.State.FINALE
