extends Control

export(Resource) var runtime_data = runtime_data as RuntimeData

onready var all_health   = $AllHealth
onready var hit_health   = $SavedHealth
onready var power_up_bar = $PowerUpBar

export var recovery_rate = 0.75
export var miss_hurt_damage = 1
export var enemy_hit_hurt_damage = 2

var enemy_level = 1


func _ready():
	connect_to_game_events()
	all_health.value = 100
	hit_health.value = 100
	power_up_bar.value = 0


func _process(delta) -> void:
	if all_health.value == 0 \
	or hit_health.value == 0:
		game_lose()


func game_start() -> void:
	visible = true


func player_missed() -> void:
	hit_health.value -= miss_hurt_damage
	all_health.value = hit_health.value
	hit_health.value = all_health.value
	
func enemy_hit() -> void:
	hit_health.value -= enemy_hit_hurt_damage * enemy_level
	

func player_defended() -> void:
	var _recoverable_health = (all_health.value - hit_health.value) * recovery_rate
	all_health.value = hit_health.value + _recoverable_health
	hit_health.value = all_health.value


func player_powered_up() -> void:
	if power_up_bar.value < 100:
		power_up_bar.value += 10
	if power_up_bar.value == 100:
		pass


func player_ran_out_of_time(dead_enemy) -> void:
	all_health.value = hit_health.value
	hit_health.value = all_health.value


func enemy_level_up() -> void:
	enemy_level += 1


func connect_to_game_events() -> void:
	GameEvents.connect("player_one_ran_out_of_time", self, "player_ran_out_of_time")
	GameEvents.connect("player_one_missed", self, "player_missed")
	GameEvents.connect("player_one_defended", self, "player_defended")
	GameEvents.connect("player_one_powered_up", self, "player_defended")
	GameEvents.connect("player_two_key_hit", self, "enemy_hit")
	GameEvents.connect("game_win", self, "game_win")
	GameEvents.connect("game_end", self, "end_of_game")
	GameEvents.connect("player_two_level_up", self, "enemy_level_up")
	
func game_lose() -> void:
	GameEvents.emit_game_end()
	GameEvents.emit_game_lose()
	runtime_data.current_gameplay_state = Enums.GameplayState.LOSE
	queue_free()

func game_win() -> void:
	queue_free()
