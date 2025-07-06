class_name Main
extends Node


@onready var pause: PauseMenu = %PauseMenu
@onready var main: MainMenu = %MainMenu
@onready var credits: CreditMenu = %CreditMenu
@onready var achievement: AchievementMenu = %AchievementMenu
@onready var end: EndMenu = %EndMenu

@onready var intro: Intro = %Intro
@onready var outro: Outro = %Outro
@onready var level: Level = $Level
@onready var music: AudioStreamPlayer = $Music


func _ready() -> void:
	Game.state = Game.State.START
	
	pause.main_selected.connect(_handle_main_selected)
	credits.main_selected.connect(_handle_main_selected)
	achievement.main_selected.connect(_handle_main_selected)
	end.main_selected.connect(_handle_end_to_main)
	
	main.play_selected.connect(_handle_play_selected)
	main.achieve_selected.connect(_handle_achieve_selected)
	main.credits_selected.connect(_handle_credits_selected)
	
	intro.finished.connect(_handle_intro_finished)
	outro.finished.connect(_handle_outro_finished)
	
	music.play()

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
	music.stop()
	if OS.is_debug_build():
		intro.visible = false
		Game.state = Game.State.SETUP
	else:
		intro.start()

func _handle_intro_finished() -> void:
	Game.state = Game.State.SETUP

func _handle_outro_finished() -> void:
	Game.state = Game.State.END
	end.open()
	music.play()

func _handle_end_to_main() -> void:
	Game.state = Game.State.START
	main.open()
	outro.reset()


func _on_music_finished():
	music.play()
