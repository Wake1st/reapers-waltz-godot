class_name InteractText
extends Control


const OPENED: float = 730
const CLOSED: float = 860

@onready var colorRect: ColorRect = $ColorRect

var target: float
var isAnimating: bool


func open() -> void:
	target = OPENED
	isAnimating = true


func close() -> void:
	target = CLOSED
	isAnimating = true


func reset() -> void:
	colorRect.position.y = CLOSED


func _ready() -> void:
	reset()

func _process(_delta) -> void:
	if Interactions.nearInteractable && !isAnimating:
		open()
	elif !Interactions.nearInteractable && !isAnimating:
		close()
	
	if isAnimating:
		colorRect.position.y = lerp(colorRect.position.y, target, 0.9)
		if is_equal_approx(colorRect.position.y, target):
			isAnimating = false
