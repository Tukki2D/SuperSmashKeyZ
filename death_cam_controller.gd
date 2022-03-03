extends Spatial

export(Resource) var runtime_data = runtime_data as RuntimeData

onready var _player_one = get_node("AnimationPlayer/PlayerKBody/PlayerOne")
onready var _player_two = get_node("AnimationPlayer/PlayerKBody/PlayerTwo")
onready var _camera = get_node("DeathCamPivot/DeathCamera")
onready var _pivot = get_node("DeathCamPivot")
onready var _target = get_node("TargetPosition")
onready var _timer = get_node("DeathDropTimer")
onready var _player = get_node("AnimationPlayer/PlayerKBody")
onready var _anim = get_node("AnimationPlayer")

export var angle_tilt = 0.05

var _camera_active = true
var _player_landed = false
var _direction := 0.00

func _ready() -> void:
	_player_one.visible = false
	_player_two.visible = false

func _process(delta) -> void:
	if _camera_active == true:
		_anim.play("player_fall_to_0")
		var _loser = loser_select()
		_loser.visible = true
		if _player_landed == false:
			pan_and_tilt_camera(delta)
			move_loser_towards_island(_loser, delta)


func move_loser_towards_island(_loser, delta) -> void:
	_player.rotate_z(angle_tilt * _timer.time_left * delta)
	_player.rotate_y(angle_tilt * _timer.time_left * delta)


func pan_and_tilt_camera(delta) -> void:
	_pivot.rotate_z(angle_tilt * _timer.time_left * delta)
	_pivot.rotate_y(angle_tilt * _timer.time_left * delta)
	_camera.set_fov(_camera.fov-1 * _timer.time_left * delta)


func loser_select():
	var _loser = null
	if runtime_data.current_gameplay_state == Enums.GameplayState.LOSE:
		_loser = _player_one
	elif runtime_data.current_gameplay_state == Enums.GameplayState.WIN:
		_loser = _player_two
	else:
		_loser = _player_one
	return _loser


func _on_DeathDropTimer_timeout():
	_player_landed = true


func _on_AnimationPlayer_animation_finished(player_fall_to_0):
	_anim.stop(false)
	
