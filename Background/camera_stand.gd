extends Spatial

export var _rotate_speed = 0.25

func _process(delta):
	rotate_y(delta * _rotate_speed)
