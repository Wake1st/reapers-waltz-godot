class_name Outro
extends Control

signal finished()

@onready var blank: ColorRect = $ColorRect

var triggered: bool


func start() -> void:
	_fade_out()

func reset() -> void:
	blank.color.a = 0.0


func _ready() -> void:
	reset()

func _process(_delta) -> void:
	if Game.state == Game.State.OUTRO && !triggered:
		triggered = true
		start()


func _fade_out() -> void:
	var tween = create_tween()
	tween.tween_property(blank, "color:a", 1.0, 4.4
		).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(_stage_finished)

func _stage_finished() -> void:
	emit_signal("finished")
