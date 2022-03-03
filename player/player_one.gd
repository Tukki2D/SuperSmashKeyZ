extends Spatial

export(Resource) var runtime_data = runtime_data as RuntimeData

onready var Enemy = preload("res://Enemy/Text_Enemy/enemy3d.tscn")
onready var Healthbar = preload("res://player/Healthbar/healthbar.tscn")
onready var enemy_container = get_node("EnemyContainer")
onready var music_player = get_node("Music_Player")

var active_enemy = null
var current_letter_index: int = -1
var current_prompt_first_letter := ""
var dead_enemy = 0


func _ready() -> void:
	randomize()
	connect_to_game_events()
	instance_healthbar()
	

func _on_GameReadyTimer_timeout() -> void:
	runtime_data.current_gameplay_state = Enums.GameplayState.CAN_TYPE
	
	
func game_ready() -> void:
	instance_healthbar()

func instance_healthbar() -> void:
	var _healthbar = Healthbar.instance()
	add_child(_healthbar)


func _unhandled_input(event: InputEvent) -> void:
	if runtime_data.current_gameplay_state == Enums.GameplayState.CAN_TYPE:
		if event is InputEventKey and event.is_pressed() and not event.is_echo():
			var typed_event = event as InputEventKey
			var key_typed = PoolByteArray([typed_event.unicode]).get_string_from_utf8()
			
			if active_enemy == null:
				find_new_active_enemy(key_typed)
			elif active_enemy != null:
				var prompt = active_enemy.get_prompt()
				var next_character = prompt.substr(current_letter_index, 1)
				if key_typed == next_character:
					proceed_to_next_key_character()
					if current_letter_index == prompt.length():
						reached_end_of_type_text()
				else:
					wrong_character_input(key_typed, next_character)
					print("incorrectly typed %s instead of %s" % [key_typed, next_character])

func find_new_active_enemy(typed_character: String):
	for enemy in enemy_container.get_children():
		var prompt = enemy.get_prompt()
		var next_character = prompt.substr(0, 1)
		current_prompt_first_letter = prompt.substr(0, 1)
		if next_character == typed_character:
			new_enemy_found(enemy)
			return


func new_enemy_found(enemy) -> void:
	GameEvents.emit_player_one_key_hit()
	active_enemy = enemy
	current_letter_index = 1
	active_enemy.set_next_character(current_letter_index)
	active_enemy.pause_timer()


func proceed_to_next_key_character() -> void:
	GameEvents.emit_player_one_key_hit()
	current_letter_index += 1
	active_enemy.set_next_character(current_letter_index)


func wrong_character_input(key_typed, next_character) -> void:
	GameEvents.emit_player_one_missed()


func reached_end_of_type_text() -> void:
	GameEvents.emit_player_one_word_complete()
	end_of_enemy_events(active_enemy)
	remove_first_letter_from_promplist_array(active_enemy.first_letter)
	current_letter_index = -1
	active_enemy.queue_free()
	active_enemy = null


#Timers and Restting Words
func end_of_enemy_events(active_enemy) -> void:
	var enemy_type = active_enemy.enemy_type
	match enemy_type:
		"Power_Up_Type":
			GameEvents.emit_power_up_end()
			GameEvents.emit_player_one_powered_up()
		"Defence_Type":
			GameEvents.emit_defence_end()
			GameEvents.emit_player_one_defended()
		"Attack_Type_One":
			GameEvents.emit_attack_one_end()
		"Attack_Type_Two":
			GameEvents.emit_attack_two_end()
		"Attack_Type_Three":
			GameEvents.emit_attack_three_end()


func spawn_type_of_enemy(type: String) -> void:
	var enemy_instance = Enemy.instance()
	enemy_instance.enemy_type = type
	enemy_container.add_child(enemy_instance)


func player_ran_out_of_time(dead_enemy) -> void:
	if active_enemy == dead_enemy:
		active_enemy = null
		current_letter_index = -1
	match dead_enemy.enemy_type:
		"Power_Up_Type":
			GameEvents.emit_power_up_end()
		"Defence_Type":
			GameEvents.emit_defence_end()
		"Attack_Type_One":
			GameEvents.emit_attack_one_end()
		"Attack_Type_Two":
			GameEvents.emit_attack_two_end()
		"Attack_Type_Three":
			GameEvents.emit_attack_three_end()
	remove_first_letter_from_promplist_array(dead_enemy.first_letter)
	dead_enemy.queue_free()


func remove_first_letter_from_promplist_array(first_letter) -> void:
	Promptlist.current_letters.erase(first_letter)

func game_end() -> void:
		queue_free_enemies()
		reset_game()


func reset_game() -> void:
	current_prompt_first_letter = ""
	active_enemy = null
	current_letter_index = -1
	current_prompt_first_letter = ""
	dead_enemy = 0


func queue_free_enemies() -> void:
	if active_enemy != null:
		active_enemy == null
	for Enemy in enemy_container.get_children():
				Enemy.queue_free()


func connect_to_game_events() -> void:
	GameEvents.connect("game_end", self, "game_end")
	GameEvents.connect("game_start", self, "game_start")
	GameEvents.connect("game_ready", self, "game_ready")
	GameEvents.connect("player_one_ran_out_of_time", self, "player_ran_out_of_time")
	GameEvents.connect("debug_key", self, "debug_key")

#Debug Key
func debug_key() -> void:
	var io = false
	if io == true:
		print("Player One - Main: Debug Key Pressed")
		if runtime_data.current_gameplay_state == Enums.GameplayState.CAN_TYPE:
			runtime_data.current_gameplay_state = Enums.GameplayState.CAN_NOT_TYPE
			print("Player One - Main: State: Can Not Type")
		elif runtime_data.current_gameplay_state == Enums.GameplayState.CAN_NOT_TYPE:
			runtime_data.current_gameplay_state = Enums.GameplayState.CAN_TYPE
			print("Player One - Main: State: Can Type")
