class_name SpikeTrap
extends Trigger


const MAX_FRAME: int = 2

@onready var sprite: Sprite2D = $Sprite2D
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var isAnimating: bool


func _process(_delta) -> void:
	if isAnimating:
		sprite.frame += 1
		if sprite.frame == MAX_FRAME:
			# kill the player
			isAnimating = false
			Game.state = Game.State.DEATH
			Achievements.add(Achievements.Type.SPIKES)
	elif Game.state == Game.State.SETUP:
		reset()


func activate() -> void:
	isAnimating = true
	audio.play()


func reset() -> void:
	sprite.frame = 0


func _on_body_entered(actor: Actor):
	if actor.isPlayer:
		Death.active = Death.Type.SPIKE
		activate()
