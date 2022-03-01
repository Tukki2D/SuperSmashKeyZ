extends Node

#Constants
const start_text_timer = 1
const text_timer = 5

signal game_ready
signal game_start
signal game_win
signal game_lose
signal game_end

#Player One
signal player_one_key_hit
signal player_one_word_complete
signal player_one_missed
signal player_one_ran_out_of_time(dead_enemy)
signal player_one_defended
signal player_one_powered_up
signal player_one_level_up

#Player Two
signal player_two_key_hit
signal player_two_word_complete
signal player_two_missed
signal player_two_ran_out_of_time(dead_enemy)
signal player_two_defended
signal player_two_powered_up
signal player_two_level_up

#TypeTimers
signal power_up_end
signal defence_end
signal attack_one_end
signal attack_two_end
signal attack_three_end

#send debug key by signal
signal debug_key


#Debug Key
func _input(event) -> void:
	if Input.is_action_just_pressed("debug_key"):
		call_deferred("emit_signal", "debug_key")
		print("Game Events: debug key pressed - signal emitted")


#Gameplay Loops
func emit_game_ready() -> void:
	call_deferred("emit_signal", "game_ready")

func emit_game_start() -> void:
	call_deferred("emit_signal", "game_start")
	
func emit_game_win() -> void:
		call_deferred("emit_signal", "game_win")

func emit_game_lose() -> void:
		call_deferred("emit_signal", "game_lose")

func emit_game_end() -> void:
	call_deferred("emit_signal", "game_end")


#Player One
func emit_player_one_key_hit() -> void:
	call_deferred("emit_signal", "player_one_key_hit")
func emit_player_one_word_complete() -> void:
	call_deferred("emit_signal", "player_one_word_complete")
func emit_player_one_missed() -> void:
	call_deferred("emit_signal", "player_one_missed")
func emit_player_one_defended() -> void:
	call_deferred("emit_signal", "player_one_defended")
func emit_player_one_powered_up() -> void:
	call_deferred("emit_signal", "player_one_owered_up")
func emit_player_one_ran_out_of_time(dead_enemy) -> void:
	call_deferred("emit_signal", "player_one_ran_out_of_time", dead_enemy)
func emit_player_one_level_up() -> void:
	call_deferred("emit_signal", "player_two_level_up")
	
#Player two
func emit_player_two_key_hit() -> void:
	call_deferred("emit_signal", "player_two_key_hit")
func emit_player_two_word_complete() -> void:
	call_deferred("emit_signal", "player_two_word_complete")
func emit_player_two_missed() -> void:
	call_deferred("emit_signal", "player_two_missed")
func emit_player_two_defended() -> void:
	call_deferred("emit_signal", "player_two_defended")
func emit_player_two_powered_up() -> void:
	call_deferred("emit_signal", "player_two_owered_up")
func emit_player_two_ran_out_of_time(dead_enemy) -> void:
	call_deferred("emit_signal", "player_two_ran_out_of_time", dead_enemy)
func emit_player_two_level_up() -> void:
	call_deferred("emit_signal", "player_two_level_up")

#Type Timers
func emit_power_up_end() -> void:
	call_deferred("emit_signal", "power_up_end")

func emit_defence_end() -> void:
	call_deferred("emit_signal", "defence_end")

func emit_attack_one_end() -> void:
	call_deferred("emit_signal", "attack_one_end")

func emit_attack_two_end() -> void:
	call_deferred("emit_signal", "attack_two_end")

func emit_attack_three_end() -> void:
	call_deferred("emit_signal", "attack_three_end")
