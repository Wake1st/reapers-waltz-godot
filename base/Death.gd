class_name Death


enum Type {
	NONE,
	SPIKE,
	CRUSH,
	DROWN,
	ENEMY,
	FALL,
}

static var active: Type = Type.NONE
static var completed: Dictionary = {
	Type.SPIKE: false,
	Type.CRUSH: false,
	Type.DROWN: false,
	Type.ENEMY: false,
	Type.FALL: false,
}
