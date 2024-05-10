extends Camera2D
@onready
var startpos = get_global_position()



func _process(delta):
	var direction = get_viewport().get_mouse_position() - global_position
	
	position = startpos + direction/5
