extends Node


func _ready() -> void:
	Game.state = Game.State.PLAY


func _input(_event) -> void:
	if Input.is_key_pressed(KEY_U):
		Achievements.add(Achievements.Type.AMULET)
		Achievements.add(Achievements.Type.CRUSHING)
		Achievements.add(Achievements.Type.DROWNING)
		Achievements.add(Achievements.Type.ENEMY)
		Achievements.add(Achievements.Type.MUSIC_BOX)
		Achievements.add(Achievements.Type.SPIKES)
		Achievements.add(Achievements.Type.SWORD)
		Achievements.add(Achievements.Type.THE_PIT)
