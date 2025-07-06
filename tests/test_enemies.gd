extends Node2D


@onready var enemy: Enemy = $Enemy
@onready var player: Player = $Player


func _ready() -> void:
	Game.state = Game.State.PLAY


func _physics_process(_delta) -> void:
	var playerPosition = player.get_actor_position() 
	if (enemy.in_pursuit()):
		if (enemy.check_caught(playerPosition)):
			player.reset(Vector2.ZERO)
			enemy.reset()
		elif (!enemy.check_pursuit(playerPosition)):
			enemy.exit_pursuit()
	else:
		enemy.check_pursuit(playerPosition)
