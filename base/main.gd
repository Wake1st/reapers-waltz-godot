class_name Main
extends Node


@onready var pause: PauseMenu = %PauseMenu
@onready var main: MainMenu = %MainMenu
@onready var credits: CreditMenu = %CreditMenu
@onready var achievement: AchievementMenu = %AchievementMenu

@onready var cutscene: Cutscene = %Cutscene
@onready var level = $Level


func _ready() -> void:
	Game.state = Game.State.START
	
	pause.main_selected.connect(_handle_main_selected)
	credits.main_selected.connect(_handle_main_selected)
	achievement.main_selected.connect(_handle_main_selected)
	main.play_selected.connect(_handle_play_selected)
	main.achieve_selected.connect(_handle_achieve_selected)
	main.credits_selected.connect(_handle_credits_selected)
	cutscene.finished.connect(_handle_cutscene_finished)

func _input(_event) -> void:
	if Input.is_action_just_pressed("pause"):
		if pause.isOpen:
			Game.state = Game.State.PLAY
			pause.close()
		else:
			Game.state = Game.State.PAUSE
			pause.open()


func _handle_main_selected() -> void:
	main.open()

func _handle_achieve_selected() -> void:
	achievement.open()

func _handle_credits_selected() -> void:
	credits.open()

func _handle_play_selected() -> void:
	if OS.is_debug_build():
		cutscene.visible = false
		Game.state = Game.State.SETUP
	else:
		cutscene.start()

func _handle_cutscene_finished() -> void:
	Game.state = Game.State.SETUP
