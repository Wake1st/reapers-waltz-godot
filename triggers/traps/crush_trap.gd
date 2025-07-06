class_name CrushTrap
extends Trigger


const MAX_FRAME: int = 5

@onready var sprite: Sprite2D = $Sprite2D
@onready var ground: Sprite2D = $Ground
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var isAnimating: bool


func _process(_delta) -> void:
	if Game.state == Game.State.START:
		ground.visible = false
	
	if isAnimating:
		sprite.frame += 1
		if sprite.frame == MAX_FRAME:
			# kill the player
			isAnimating = false
			ground.visible = true
			Game.state = Game.State.DEATH
			Achievements.add(Achievements.Type.CRUSHING)
	elif Game.state == Game.State.SETUP:
		reset()


func activate() -> void:
	isAnimating = true
	audio.pitch_scale = randf_range(0.8, 1.0)
	audio.volume_db = randf_range(-1, 1)
	audio.play()


func reset() -> void:
	sprite.frame = 0


func _on_body_entered(actor: Actor):
	if actor.isPlayer:
		Death.active = Death.Type.CRUSH
		activate()
