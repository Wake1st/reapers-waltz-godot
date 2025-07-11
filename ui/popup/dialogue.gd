class_name Dialogue
extends Control


enum Type {
	SWORD,
	MUSIC,
	AMULET,
}

const OPENED: float = 0.0
const CLOSED: float = 870.0

@export var type: Type
@export var questionText: String
@export var responseText: String

@onready var panel: TextureRect = $Panel
@onready var question: Label = $Panel/Question
@onready var noBtn: Button = $Panel/NoBtn
@onready var yesBtn: Button = $Panel/YesBtn
@onready var response: Label = $Panel/Response
@onready var resumeBtn: TextureButton = $Panel/ResumeBtn

var target: float
var isAnimating: bool


func open() -> void:
	target = OPENED
	isAnimating = true


func close() -> void:
	target = CLOSED
	isAnimating = true
	Game.state = Game.State.PLAY


func reset() -> void:
	panel.position.y = CLOSED
	_toggle_stage(true)


func _ready() -> void:
	question.text = questionText
	response.text = responseText
	reset()

func _process(_delta) -> void:
	if isAnimating:
		panel.position.y = lerp(panel.position.y, target, 0.8)
		if is_equal_approx(panel.position.y, target):
			panel.position.y = target
			isAnimating = false


func _on_no_btn_pressed() -> void:
	close()

func _on_yes_btn_pressed() -> void:
	_toggle_stage(false)

func _on_resume_btn_pressed() -> void:
	close()
	_add_achievement()


func _toggle_stage(value: bool) -> void:
	question.visible = value
	noBtn.visible = value
	yesBtn.visible = value
	noBtn.disabled = !value
	yesBtn.disabled = !value
	
	response.visible = !value
	resumeBtn.disabled = value
	resumeBtn.visible = !value

func _add_achievement() -> void:
	match type:
		Type.SWORD:
			Achievements.add(Achievements.Type.SWORD)
		Type.MUSIC:
			Achievements.add(Achievements.Type.MUSIC_BOX)
		Type.AMULET:
			Achievements.add(Achievements.Type.AMULET)
