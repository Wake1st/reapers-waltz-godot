class_name AudioQueue


static var queue: int


static func write() -> void:
	queue += 1


static func read() -> int:
	var res = queue
	queue = 0
	return res
