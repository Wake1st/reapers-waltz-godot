class_name Camera
extends Camera2D


const OPENED: float = -600.0
const CLOSED: float = 0.0

@onready var timer: Timer = $Timer

var isAnimating: bool
var target: float
var tween: Tween


func _physics_process(_delta) -> void:
	if EventHandler.finalCinematic && !isAnimating:
		isAnimating = true
		Game.state = Game.State.PAUSE
		slide(true)


func slide(open: bool) -> void:
	var duration: float
	if open:
		target = OPENED
		duration = 2.6
	else:
		target = CLOSED
		duration = 0.2
	
	tween = create_tween()
	tween.tween_property(self, "position:x", target, duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(_on_slide_finished.bind(open))


func _on_slide_finished(opened: bool) -> void:
	if opened:
		timer.start()
	else:
		_on_timer_timeout()

func _on_timer_timeout() -> void:
	Game.state = Game.State.PLAY
	slide(false)
