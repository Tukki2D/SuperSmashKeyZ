extends Control

export(Resource) var runtime_data = runtime_data as RuntimeData

onready var all_health = get_node("AllHealth")
onready var power_up_bar = get_node("PowerUpBar")

export var key_hit_damage = 1
export var word_finish_damage = 3
var enemy_level = 1

func _ready() -> void:
	GameEvents_Connect()
	all_health.value   = 100
	power_up_bar.value = 0
	enemy_level = 1
	
func _process(delta) -> void:
	if all_health.value <= 0:
		game_win()
	
func player_two_hurt() -> void:
	all_health.value -= key_hit_damage

func word_complete() -> void:
	all_health.value -= word_finish_damage



func enemy_level_up() -> void:
	if all_health.value <= 66 \
	 and enemy_level != 2:
		GameEvents.emit_player_two_level_up()
	if all_health.value <= 33 \
	 and enemy_level != 3:
		GameEvents.emit_player_two_level_up()


func game_win() -> void:
	runtime_data.current_gameplay_state = Enums.GameplayState.WIN
	GameEvents.emit_game_end()
	GameEvents.emit_game_win()
	queue_free()


func game_end() -> void:
	queue_free()

func GameEvents_Connect() -> void:
	GameEvents.connect("player_one_key_hit", self, "player_two_hurt")
	GameEvents.connect("word_complete", self, "word_complete")
	GameEvents.connect("game_end", self, "game_end")
