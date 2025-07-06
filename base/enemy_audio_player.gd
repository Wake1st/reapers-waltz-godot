class_name EnemyAudioPlayer
extends AudioStreamPlayer


func _process(_delta) -> void:
	var result = AudioQueue.read()
	if result > 0:
		play()
