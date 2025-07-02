class_name MainMenu
extends Control


signal play_selected()
signal achieve_selected()
signal credits_selected()

const OPENED: float = 0.0
const CLOSED: float = 870.0
const WEIGHT: float = 0.8

@onready var panel: TextureRect = $Panel
@onready var playBtn: TextureButton = %PlayBtn
@onready var creditsBtn: TextureButton = %CreditsBtn
@onready var exitBtn: TextureButton = %ExitBtn

var target: float
var isAnimating: bool


func open() -> void:
	target = OPENED
	isAnimating = true
	Game.state = Game.State.START


func close() -> void:
	target = CLOSED
	isAnimating = true
	Game.state = Game.State.PLAY


func _ready() -> void:
	panel.position.y = OPENED

func _process(_delta) -> void:
	if isAnimating:
		panel.position.y = lerp(panel.position.y, target, WEIGHT)
		if is_equal_approx(panel.position.y, target):
			panel.position.y = target
			isAnimating = false


func _on_play_btn_pressed():
	close()
	emit_signal("play_selected")

func _on_achieve_btn_pressed():
	emit_signal("achieve_selected")

func _on_credits_btn_pressed():
	emit_signal("credits_selected")

func _on_exit_btn_pressed():
	get_tree().quit()
