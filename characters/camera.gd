class_name Camera
extends Camera2D


const OPENED: float = -300.0
const CLOSED: float = 0.0
const OPEN_DURATION: float = 2.4
const WAIT_DURATION: float = 1.2
const CLOSE_DURATION: float = 0.2

@onready var timer: Timer = $Timer

var isAnimating: bool
var target: float
var tween: Tween


func _physics_process(_delta) -> void:
	if Game.state == Game.State.FINALE && !isAnimating:
		isAnimating = true
		slide(true)


func slide(open: bool) -> void:
	var duration: float
	if open:
		target = OPENED
		duration = OPEN_DURATION
	else:
		target = CLOSED
		duration = CLOSE_DURATION
	
	tween = create_tween()
	tween.tween_property(self, "position:x", target, duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(_on_slide_finished.bind(open))


func _on_slide_finished(opened: bool) -> void:
	if opened:
		timer.start(WAIT_DURATION)
	else:
		_on_timer_timeout()

func _on_timer_timeout() -> void:
	Game.state = Game.State.PLAY
	slide(false)
