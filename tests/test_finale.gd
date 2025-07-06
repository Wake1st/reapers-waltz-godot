extends Node2D


@onready var player: Player = $Player
@onready var spawner: ChaseSpawner = $ChaseSpawner


func _ready():
	Game.state = Game.State.PLAY


func _physics_process(_delta) -> void:
	spawner.check_pursuit(player.get_actor_position()) 
