class_name Tapestry
extends Control


@onready var amulet: TextureRect = $Amulet
@onready var crushing: TextureRect = $Crushing
@onready var drowning: TextureRect = $Drowning
@onready var enemy: TextureRect = $Enemy
@onready var musicBox: TextureRect = $MusicBox
@onready var spikes: TextureRect = $Spikes
@onready var sword: TextureRect = $Sword
@onready var thePit: TextureRect = $ThePit


func unlock_tapestry(type: Achievements.Type) -> void:
	match type:
		Achievements.Type.AMULET:
			amulet.visible = true
		Achievements.Type.CRUSHING:
			crushing.visible = true
		Achievements.Type.DROWNING:
			drowning.visible = true
		Achievements.Type.ENEMY:
			enemy.visible = true
		Achievements.Type.MUSIC_BOX:
			musicBox.visible = true
		Achievements.Type.SPIKES:
			spikes.visible = true
		Achievements.Type.SWORD:
			sword.visible = true
		Achievements.Type.THE_PIT:
			thePit.visible = true


func _process(_delta) -> void:
	if Achievements.added != Achievements.Type.NONE:
		unlock_tapestry(Achievements.added)
		Achievements.added = Achievements.Type.NONE


func reset() -> void:
	amulet.visible = false
	crushing.visible = false
	drowning.visible = false
	enemy.visible = false
	musicBox.visible = false
	spikes.visible = false
	sword.visible = false
	thePit.visible = false


func _ready() -> void:
	reset()
