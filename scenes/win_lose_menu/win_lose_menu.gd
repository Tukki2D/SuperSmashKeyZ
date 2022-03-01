extends Spatial

export(Resource) var runtime_data = runtime_data as RuntimeData

onready var Win_Handle = get_node("Win_Text")
onready var Lose_Handle = get_node("Lose_Text")
onready var Logo = get_node("Logo")

export var font_size = 65
var fight_ready = false

func _ready() -> void:
	if runtime_data.current_gameplay_state == Enums.GameplayState.MENUS:
		runtime_data.current_gameplay_state = Enums.GameplayState.READY
		GameEvents.emit_signal("game_ready")
		emit_text_signals()
		queue_free()


func _unhandled_key_input(event):
	if Input.is_action_pressed("Start_Game") \
	and fight_ready == true:
		runtime_data.current_gameplay_state = Enums.GameplayState.READY
		GameEvents.emit_signal("game_ready")
		emit_text_signals()
		queue_free()


func _process(delta) -> void:
	if runtime_data.current_gameplay_state == Enums.GameplayState.WIN:
		Win_Handle.visible = true
		Lose_Handle.visible = false
	elif runtime_data.current_gameplay_state == Enums.GameplayState.LOSE:
		Lose_Handle.visible = true
		Win_Handle.visible = false


func emit_text_signals() -> void:
	GameEvents.emit_signal("power_up_end")
	GameEvents.emit_signal("defence_end")
	GameEvents.emit_signal("attack_one_end")
	GameEvents.emit_signal("attack_two_end")
	GameEvents.emit_signal("attack_three_end")


func set_rich_code_font_and_size(prompt):
	var font = "res://imports/DarkUnderground.ttf"
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load(font)
	dynamic_font.size = font_size
	dynamic_font.outline_size = 5
	dynamic_font.outline_color = Color.black
	prompt.add_font_override("normal_font", dynamic_font)
	return dynamic_font.size

func _on_Timer_timeout():
	fight_ready = true
