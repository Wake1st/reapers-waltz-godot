extends Node


@onready var crush: CrushTrap = $CrushTrap
@onready var spike: SpikeTrap = $SpikeTrap
@onready var water: WaterTrap = $WaterTrap
@onready var fall: FallTrap = $FallTrap
@onready var player: Player = $Player
@onready var enemy: Enemy = $Enemy
@onready var timer: Timer = $Timer


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
			var playerPosition = player.get_actor_position() 
			if (enemy.in_pursuit()):
				if (enemy.check_caught(playerPosition)):
					player.reset(Vector2.ZERO)
					enemy.reset()
				elif (!enemy.check_pursuit(playerPosition)):
					enemy.exit_pursuit()
			else:
				enemy.check_pursuit(playerPosition)
		Game.State.DEATH:
			_animate_death()
			player.isFrozen = true


func _animate_death() -> void:
	# play unique animation
	match Death.active:
		Death.Type.NONE:
			return
		Death.Type.DROWN, Death.Type.FALL:
			player.visible = false
		Death.Type.SPIKE, Death.Type.CRUSH:
			player.actor.rotate(randf_range(-PI/5, PI/5))
	
	# should run once
	timer.start()
	Death.active = Death.Type.NONE

func _on_timer_timeout():
	Game.state = Game.State.SETUP
