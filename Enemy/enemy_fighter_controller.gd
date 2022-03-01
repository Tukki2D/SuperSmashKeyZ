extends Spatial

export(Resource) var runtime_data = runtime_data as RuntimeData

onready var AttackAlarm = get_node("AttackAlarm")


func _ready():
	GameEvents_Connect()
	randomize()


func _on_AttackAlarm_timeout():
	randomize()
	if runtime_data.current_gameplay_state == Enums.GameplayState.CAN_TYPE:
		var hit_miss = rand_range(-1, 2)
		if hit_miss <= 0:
			GameEvents.emit_player_two_missed()
		elif hit_miss > 0:
			GameEvents.emit_player_two_key_hit()
		var time_until_next_attack = rand_range(0.1, 0.25)
		AttackAlarm.start(time_until_next_attack)



func GameEvents_Connect() -> void:
	GameEvents.connect("game_ready", self, "game_ready")
	GameEvents.connect("player_two_key_hit", self, "enemy_hit")
	GameEvents.connect("player_two_miss", self, "enemy_miss")
	GameEvents.connect("player_one_key_hit", self, "enemy_hurt")
	GameEvents.connect("game_lose", self, "enemy_win")
	GameEvents.connect("game_win", self, "enemy_lose")
	GameEvents.connect("game_end", self, "game_end")
	GameEvents.connect("player_two_level_up", self, "enemy_level_up")
