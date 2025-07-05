class_name Level
extends Node2D


@onready var player: Player = $Player
@onready var timer: Timer = $Timer

@onready var enemies: Node2D = $Enemies
@onready var crushs: Node2D = $CrushTraps
@onready var spikes: Node2D = $SpikeTraps
@onready var waters: Node2D = $WaterTraps
@onready var pits: Node2D = $PitTraps

@onready var chase_trigger: EventTrigger = $ChaseTrigger
@onready var chase_spawner: ChaseSpawner = %ChaseSpawner


func _process(_delta) -> void:
	match Game.state:
		Game.State.SETUP:
			_reset_level()
			if OS.is_debug_build():
				player.speed = 320
				player.position = Vector2(4161, 1715)
			Game.state = Game.State.PLAY
		Game.State.PLAY:
			_check_enemies()
		Game.State.DEATH:
			_animate_death()
			player.isFrozen = true
		Game.State.FINALE:
			chase_spawner.check_pursuit(player.get_actor_position()) 


func _animate_death() -> void:
	# play unique animation
	match Death.active:
		Death.Type.NONE:
			return
		Death.Type.DROWN, Death.Type.FALL, Death.Type.CRUSH:
			player.visible = false
		Death.Type.SPIKE:
			player.actor.rotate(randf_range(-PI/5, PI/5))
	
	# should run once
	timer.start()
	Death.active = Death.Type.NONE

func _on_timer_timeout():
	Game.state = Game.State.SETUP


func _reset_level() -> void:
	player.reset(Vector2.ZERO)
	
	for enemy in enemies.get_children():
		enemy.reset()
	for spike in spikes.get_children():
		spike.reset()
	for crush in crushs.get_children():
		crush.reset()

func _check_enemies() -> void:
	var playerPosition = player.get_actor_position()
	for enemy in enemies.get_children():
		# skip if despawned
		if enemy == null:
			continue
		
		if (enemy.in_pursuit()):
			if (enemy.check_caught(playerPosition)):
				player.reset(Vector2.ZERO)
				enemy.reset()
			elif (!enemy.check_pursuit(playerPosition)):
				enemy.exit_pursuit()
		else:
			enemy.check_pursuit(playerPosition)
