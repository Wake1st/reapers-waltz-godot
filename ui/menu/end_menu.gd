class_name EndMenu
extends Control


signal main_selected()

const OPENED: float = 0.0
const CLOSED: float = 870.0
const WEIGHT: float = 0.8

@onready var panel: TextureRect = $Panel
@onready var menuBtn: TextureButton = %MenuBtn

var target: float
var isAnimating: bool


func open() -> void:
	target = OPENED
	isAnimating = true


func close() -> void:
	target = CLOSED
	isAnimating = true


func _ready() -> void:
	panel.position.y = CLOSED

func _process(_delta) -> void:
	if isAnimating:
		panel.position.y = lerp(panel.position.y, target, WEIGHT)
		if is_equal_approx(panel.position.y, target):
			panel.position.y = target
			isAnimating = false


func _on_menu_btn_pressed():
	close()
	emit_signal("main_selected")
