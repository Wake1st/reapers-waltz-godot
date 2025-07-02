class_name Cutscene
extends Control


signal finished()

enum Stage {
	FADE_IN,
	ROOM,
	BLANK,
	FADE_OUT,
}

const IMAGE_RATIO: float = 0.6
const FINAL_SCALE: float = 1.7
const FINAL_POSITION: Vector2 = Vector2(-148, -446)
const FADE_IN_DURATION: float = 4.2
const ROOM_DURATION: float = 19.0
const BLANK_DURATION: float = 2.8
const FADE_OUT_DURATION: float = 3.6

@onready var shot: TextureRect = $TextureRect
@onready var blank: ColorRect = $ColorRect
@onready var deathAudio: AudioStreamPlayer2D = $Death
@onready var music: AudioStreamPlayer2D = $Music
@onready var timer: Timer = $Timer

var stage: Stage
var tween: Tween


func start() -> void:
	_fade_in()


func reset() -> void:
	stage = Stage.FADE_IN
	timer.stop()
	blank.color.a = 1.0
	shot.size = Vector2(1400, 840)
	shot.position = Vector2.ZERO
	music.volume_db = -18


func _ready() -> void:
	reset()

func _fade_in() -> void:
	stage = Stage.FADE_IN
	music.play()
	
	tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(blank, "color:a", 0.0, FADE_IN_DURATION
		).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(music, "volume_db", 12, FADE_IN_DURATION
		).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.set_parallel(false)
	tween.tween_callback(_stage_finished)

func _room() -> void:
	stage = Stage.ROOM
	tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(shot, "size", size * FINAL_SCALE, ROOM_DURATION
		).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(shot, "position", FINAL_POSITION, ROOM_DURATION
		).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(music, "volume_db", 22, FADE_IN_DURATION
		).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.set_parallel(false)
	tween.tween_callback(_stage_finished)

func _black() -> void:
	stage = Stage.BLANK
	blank.color.a = 1.0
	shot.visible = false
	deathAudio.play()
	music.stop()
	timer.start(BLANK_DURATION)

func _fade_out() -> void:
	stage = Stage.FADE_OUT
	tween = create_tween()
	tween.tween_property(blank, "color:a", 0.0, FADE_OUT_DURATION)
	tween.tween_callback(_stage_finished)

func _stage_finished() -> void:
	match stage:
		Stage.FADE_IN:
			_room()
		Stage.ROOM:
			_black()
		Stage.BLANK:
			_fade_out()
		Stage.FADE_OUT:
			emit_signal("finished")
