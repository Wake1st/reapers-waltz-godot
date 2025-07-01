class_name FallTrap
extends Trigger


@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D


func activate() -> void:
	Game.state = Game.State.DEATH
	Achievements.add(Achievements.Type.THE_PIT)
	audio.play()


func _on_body_entered(actor: Actor):
	if actor.isPlayer:
		Death.active = Death.Type.FALL
		activate()
