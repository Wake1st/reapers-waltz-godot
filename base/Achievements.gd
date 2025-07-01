class_name Achievements


enum Type {
	NONE,
	AMULET,
	CRUSHING,
	DROWNING,
	ENEMY,
	MUSIC_BOX,
	SPIKES,
	SWORD,
	THE_PIT,
}

static var achievements: Dictionary = {
	Type.AMULET: false,
	Type.CRUSHING: false,
	Type.DROWNING: false,
	Type.ENEMY: false,
	Type.MUSIC_BOX: false,
	Type.SPIKES: false,
	Type.SWORD: false,
	Type.THE_PIT: false,
}

static var added: Type


static func add(type: Type) -> void:
	achievements[type] = true;
	added = type

static func all_achieved() -> bool:
	for value in achievements.values():
		if !value:
			return false
	return true
