extends Spatial

export(Resource) var runtime_data = runtime_data as RuntimeData

var hit_frames = [
	"1",
	"2",
	"3"
]

var hurt_frames = [
	"4",
	"5",
]

var power_up_frames = [
	"6"
]

onready var _animator_one = get_node("PlayerOneAnim")
onready var _animator_two = get_node("PlayerTwoAnim")
onready var _player_one_timer = get_node("PlayerOneTimer")
onready var _player_two_timer = get_node("PlayerTwoTimer")

func _ready() -> void:
	connect_to_gamevents()
	set_start_animations()


func game_ready() -> void:
	_animator_one.visible = true
	_animator_two.visible = true
	_animator_one.frame = 0
	_animator_two.frame = 0
	
func game_end() -> void:
	_animator_one.visible = false
	_animator_two.visible = false

func set_start_animations() -> void:
	_animator_one.animation = "white"
	_animator_two.animation = "gray"

func player_one_key_hit() -> void:
	_animator_one.frame = get_frame(hit_frames)
	_animator_two.frame = get_frame(hurt_frames)

func player_two_key_hit() -> void:
	_animator_two.frame = get_frame(hit_frames)
	_animator_one.frame = get_frame(hurt_frames)
	
func player_one_power_up() -> void:
	_animator_one.frame = get_frame(power_up_frames)
	
	
func player_two_power_up() -> void:
	_animator_two.frame = get_frame(power_up_frames)
	
func get_frame(array_to_get_size):
	randomize()
	var rand_index: int = randi() % array_to_get_size.size()
	var index_number = array_to_get_size[rand_index] 
	rand_index = int(float(index_number))
	return rand_index

func connect_to_gamevents() -> void:
	GameEvents.connect("player_one_key_hit", self, "player_one_key_hit")
	GameEvents.connect("player_two_key_hit", self, "player_two_key_hit")
	GameEvents.connect("player_one_powered_up", self, "player_one_power_up")
	GameEvents.connect("player_two_powered_up", self, "player_two_power_up")
	GameEvents.connect("game_end", self, "game_end")
	GameEvents.connect("game_ready", self, "game_ready")
	GameEvents.connect("game_start", self, "game_start")

