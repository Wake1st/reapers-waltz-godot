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
const CAUGHT_DISTANCE: float = 15
const PATROL_DISTANCE: float = 1

@export var pursueDistance: float = 280
@export var speed: float = 65
@export var patrolPoints: Array[Vector2]

@onready var actor: Actor = $Actor

var state: EnemyState

var idleTimer: float
var pointIndex: int

var target: Vector2


func _ready() -> void:
	#actor.set_platform_floor_layers(0xFFFFFFFF)
	reset()


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
			actor.move(direction * speed * delta)
			
			# check for arrival
			if (actor.global_position.distance_to(target) < PATROL_DISTANCE):
				actor.global_position = target
				state = EnemyState.IDLE
		EnemyState.PURSUIT:
			direction = _get_direction()
			actor.move(direction * speed * delta)
	
	actor.animate(direction, delta)


func reset() -> void:
	pointIndex = 0
	target = patrolPoints[pointIndex]
	actor.global_position = target
	idleTimer = IDLE_TIME


func in_pursuit() -> bool:
	return state == EnemyState.PURSUIT


func check_pursuit(checkPosition: Vector2) -> bool:
	if (actor.global_position.distance_to(checkPosition) < pursueDistance):
		target = checkPosition
		if (state != EnemyState.PURSUIT):
			_enter_pursuit()
		return true
	else:
		return false


func check_caught(checkPosition: Vector2) -> bool:
	if (actor.global_position.distance_to(checkPosition) < CAUGHT_DISTANCE):
		exit_pursuit()
		return true
	else:
		return false


func _enter_pursuit() -> void:
	state = EnemyState.PURSUIT
	actor.texture = HOSTILE

func exit_pursuit() -> void:
	state = EnemyState.IDLE
	actor.texture = DOCILE

func _get_direction() -> Vector2:
	return actor.global_position.direction_to(target)
