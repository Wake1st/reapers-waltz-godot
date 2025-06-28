extends Node2D


@onready var player: Player = $Player
@onready var crush: CrushTrap = $CrushTrap
@onready var spike: SpikeTrap = $SpikeTrap
@onready var timer: Timer = $DeathTimer


func _ready() -> void:
	Game.state = Game.State.SETUP


func _process(_delta) -> void:
	match Game.state:
		Game.State.SETUP:
			player.reset(Vector2.ZERO)
			spike.reset()
			crush.reset()
			Game.state = Game.State.PLAY
		Game.State.PLAY:
			pass
		Game.State.DEATH:
			_animate_death()
			player.isFrozen = true


func _animate_death() -> void:
	# play unique animation
	match Death.active:
		Death.Type.NONE:
			return
		Death.Type.CRUSH:
			player.visible = false
		Death.Type.SPIKE:
			player.actor.rotate(-PI/5)
	
	# should run once
	timer.start()
	Death.active = Death.Type.NONE


func _on_death_timer_timeout():
	Game.state = Game.State.SETUP
