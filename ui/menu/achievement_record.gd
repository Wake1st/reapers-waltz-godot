@tool
class_name AchievementRecord
extends Control


@export var text: String:
	set(value):
		text = value
		if has_node("Label"):
			get_node("Label").text = value
@export var type: Achievements.Type

@onready var check_box: CheckBox = $CheckBox


func reset() -> void:
	check_box.toggle_mode = Achievements.achievements[type]
