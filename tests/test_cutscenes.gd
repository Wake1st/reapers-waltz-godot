extends Control


#@onready var cutscene: Intro = $Intro
@onready var cutscene: Outro = $Outro


func _ready() -> void:
	cutscene.finished.connect(_handle_finished)


func _input(_event) -> void:
	if Input.is_action_just_pressed("action"):
		cutscene.start()
	if Input.is_action_just_pressed("pause"):
		cutscene.reset()


func _handle_finished() -> void:
	print("DONE!")
