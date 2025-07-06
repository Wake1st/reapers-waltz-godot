class_name InputHandler


static var deadzone: float = 0.1

static func get_direction() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down", deadzone)


static func get_action() -> bool:
	return Input.is_action_just_pressed("action")
