extends Control


@onready var pause: PauseMenu = $PauseMenu
@onready var main: MainMenu = $MainMenu
@onready var credits: CreditMenu = $CreditMenu
@onready var achievement: AchievementMenu = $AchievementMenu


func _ready() -> void:
	pause.main_selected.connect(_handle_main_selected)
	credits.main_selected.connect(_handle_main_selected)
	achievement.main_selected.connect(_handle_main_selected)
	main.play_selected.connect(_handle_play_selected)
	main.achieve_selected.connect(_handle_achieve_selected)
	main.credits_selected.connect(_handle_credits_selected)

func _input(_event) -> void:
	if Input.is_action_just_pressed("pause"):
		if pause.isOpen:
			pause.close()
		else:
			pause.open()


func _handle_main_selected() -> void:
	main.open()

func _handle_achieve_selected() -> void:
	achievement.open()

func _handle_credits_selected() -> void:
	credits.open()

func _handle_play_selected() -> void:
	# play the cutscene
	pass
