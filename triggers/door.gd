class_name Door
extends StaticBody2D


@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

var opened: bool


func _process(_delta) -> void:
	if Achievements.all_achieved() && !opened:
		opened = true
		visible = false
		collision.disabled = true
