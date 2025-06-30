class_name Interactable
extends Area2D


@export var image: Texture2D:
	set(value):
		image = value
		if has_node("Sprite2D"):
			get_node("Sprite2D").texture = value
@export var popup: Dialogue

var isActive: bool


func _ready() -> void:
	reset()


func activate(value: bool) -> void:
	isActive = value
	Interactions.nearInteractable = value


func reset() -> void:
	popup.close()


func _on_body_entered(actor: Actor) -> void:
	if actor.isPlayer:
		activate(true)

func _on_body_exited(actor: Actor) -> void:
	if actor.isPlayer:
		activate(false)

func _input(_event) -> void:
	if isActive && Input.is_action_just_pressed("action"):
		popup.open()
		Game.state = Game.State.PAUSE
