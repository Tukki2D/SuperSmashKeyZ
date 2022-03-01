extends Node

export(Resource) var runtime_data = runtime_data as RuntimeData

onready var power_up_timer = $PowerUpTimer
onready var defence_timer = $DefenceTimer
onready var attack_one_timer = $AttackOneTimer
onready var attack_two_timer = $AttackTwoTimer
onready var attack_three_timer = $AttackThreeTimer

onready var Main = get_parent()

func _ready() -> void:
	connect_to_signals()


func _on_PowerUpTimer_timeout():
	if runtime_data.current_gameplay_state == Enums.GameplayState.CAN_TYPE:
		Main.spawn_type_of_enemy("Power_Up_Type")

func _on_DefenceTimer_timeout():
	if runtime_data.current_gameplay_state == Enums.GameplayState.CAN_TYPE:
		Main.spawn_type_of_enemy("Defence_Type")


func _on_AttackOneTimer_timeout():
	if runtime_data.current_gameplay_state == Enums.GameplayState.CAN_TYPE:
		Main.spawn_type_of_enemy("Attack_Type_One")


func _on_AttackTwoTimer_timeout():
	if runtime_data.current_gameplay_state == Enums.GameplayState.CAN_TYPE:
		Main.spawn_type_of_enemy("Attack_Type_Two")


func _on_AttackThreeTimer_timeout():
	if runtime_data.current_gameplay_state == Enums.GameplayState.CAN_TYPE:
		Main.spawn_type_of_enemy("Attack_Type_Three")

#Reset Tiemrs on Enemy Death
func reset_power_up_end() -> void: 
	power_up_timer.start()

func reset_defence_end() -> void:
	defence_timer.start()

func reset_attack_one_end() -> void:
	attack_one_timer.start()

func reset_attack_two_end() -> void:
	attack_two_timer.start()

func reset_attack_three_end() -> void:
	attack_three_timer.start()


func game_end() -> void:
	power_up_timer.stop()
	defence_timer.stop()
	attack_one_timer.stop()
	attack_two_timer.stop()
	attack_three_timer.stop()


func connect_to_signals() -> void:
	GameEvents.connect("power_up_end", self, "reset_power_up_end")
	GameEvents.connect("defence_end", self, "reset_defence_end")
	GameEvents.connect("attack_one_end", self, "reset_attack_one_end")
	GameEvents.connect("attack_two_end", self, "reset_attack_two_end")
	GameEvents.connect("attack_three_end", self, "reset_attack_three_end")
	GameEvents.connect("game_end", self, "game_end")
