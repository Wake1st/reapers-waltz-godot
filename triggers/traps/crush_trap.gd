class_name CrushTrap
extends Trigger


const MAX_FRAME: int = 5

@onready var sprite: Sprite2D = $Sprite2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var isAnimating: bool


func _ready() -> void:
	super._ready()


func _process(_delta) -> void:
	if isAnimating:
		sprite.frame += 1
		if sprite.frame == MAX_FRAME:
			# kill the player
			isAnimating = false
			Game.state = Game.State.DEATH
			Achievements.add(Achievements.Type.CRUSHING)
	elif Game.state == Game.State.SETUP:
		reset()


func activate() -> void:
	isAnimating = true
	audio.play()


func reset() -> void:
	sprite.frame = 0


func _on_body_entered(actor: Actor):
	if actor.isPlayer:
		Death.active = Death.Type.CRUSH
		activate()
