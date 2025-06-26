class_name Enemy
extends Node2D


enum EnemyState
{
	IDLE,
	PATROL,
	PURSUIT,
}

const DOCILE = preload("res://assets/spritesheets/Enemy_blue_evil_non-hos.png")
const HOSTILE = preload("res://assets/spritesheets/Enemy_blue_evil.png")

const IDLE_TIME: float = 2.5
const ENEMY_SPEED: float = 85
const PURSUE_DISTANCE: float = 200
const CAUGHT_DISTANCE: float = 20
const PATROL_DISTANCE: float = 0.1

@export var patrolPoints: Array[Vector2]

@onready var actor: Actor = $Actor

var state: EnemyState

var idleTimer: float
var pointIndex: int

var target: Vector2


func _ready() -> void:
	target = patrolPoints[0]
	actor.position = target
	idleTimer = IDLE_TIME


func _physics_process(delta) -> void:
	var direction := Vector2.ZERO
	
	match (state):
		EnemyState.IDLE:
			idleTimer -= delta
			if (idleTimer <= 0):
				idleTimer = IDLE_TIME
				pointIndex = (pointIndex + 1) % patrolPoints.size()
				target = patrolPoints[pointIndex]
				state = EnemyState.PATROL
		EnemyState.PATROL:
			direction = _get_direction()
			actor.move(direction * ENEMY_SPEED * delta)
			
			# check for arrival
			if (actor.position.distance_to(target) < PATROL_DISTANCE):
				actor.position = target
		EnemyState.PURSUIT:
			direction = _get_direction()
			actor.move(direction * ENEMY_SPEED * delta)
			
			_check_caught()
	
	actor.animate(direction, delta)


func check_pursuit(checkPosition: Vector2) -> bool:
	if (actor.position.distance_to(checkPosition) < PURSUE_DISTANCE):
		target = checkPosition
		_enter_pursuit()
		return true
	else:
		return false


func _check_caught() -> bool:
	if (actor.position.distance_to(target)):
		_exit_pursuit()
		return true
	else:
		return false

func _enter_pursuit() -> void:
	state = EnemyState.PURSUIT
		# swap out texture

func _exit_pursuit() -> void:
	state = EnemyState.IDLE
		# swap out texture

func _get_direction() -> Vector2:
	return actor.position.direction_to(target)
