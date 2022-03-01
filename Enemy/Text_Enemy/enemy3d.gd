extends Spatial

export (Color) var blue = Color("#4682b4")
export (Color) var green = Color("#639765")
export (Color) var red = Color("#a65455")
export var font_size = 65
export var large_font_size = 70

onready var prompt = $CenterRichBody
onready var prompt_text = prompt.text
var first_letter = ""

var timer = null
var enemy_type = "No_Type"


#Ready Functions
func _ready() -> void:
	randomize()
	set_prompt()
	start_timers()
	font_size = set_rich_code_font_and_size(prompt)
	set_prompt_text()

func set_prompt() -> void:
	match enemy_type:
		"Power_Up_Type":
			prompt = $PowerUpText
		"Defence_Type":
			prompt = $DefenceText
		"Attack_Type_One":
			prompt = $AttackOneText
		"Attack_Type_Two":
			prompt = $AttackTwoText
		"Attack_Type_Three":
			prompt = $AttackThreeText
	prompt.visible = true


func start_timers() -> void:
	match enemy_type:
		"Power_Up_Type":
			pass
		"Defence_Type":
			pass
		"Attack_Type_One":
			$Timer/AttackOneTimer.start(GameEvents.text_timer)
			timer = $Timer/AttackOneTimer
		"Attack_Type_Two":
			$Timer/AttackTwoTimer.start(GameEvents.text_timer)
			timer = $Timer/AttackTwoTimer
		"Attack_Type_Three":
			$Timer/AttackThreeTimer.start(GameEvents.text_timer)
			timer = $Timer/AttackThreeTimer

func get_prompt() -> String:
	return prompt_text


#Rich Code
func set_next_character(next_character_index: int):
	var blue_text = bbc_return_string_with_color(blue, 0, next_character_index)
	var green_text = bbc_return_string_with_color(green, next_character_index, 1)
	var red_text = ""
	if next_character_index != prompt.text.length():
		red_text = bbc_return_string_with_color(red, next_character_index + 1, prompt_text.length() - next_character_index + 1)
	prompt.parse_bbcode(set_center_tags(blue_text + green_text + red_text))

func set_center_tags(string_to_center: String):
	return "[center]" + string_to_center + "[/center]"

func bbc_return_string_with_color(color: Color, to: int, from: int) -> String:
	return "[color=#" + color.to_html(false) + "]" + prompt_text.substr(to, from) + "[/color]"

func set_rich_code_font_and_size(prompt):
	var font = "res://imports/DarkUnderground.ttf"
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load(font)
	dynamic_font.size = font_size
	dynamic_font.outline_size = 5
	dynamic_font.outline_color = Color.black
	prompt.add_font_override("normal_font", dynamic_font)
	return dynamic_font.size


func set_prompt_text() -> void:
	prompt_text = Promptlist.get_prompt()
	first_letter = prompt_text.substr(0, 1)
	prompt.parse_bbcode(set_center_tags(prompt_text))

#Timers
func pause_timer() -> void:
	if timer != null:
		timer.set_paused(true)

func _on_AttackOneTimer_timeout():
	emit_type_death_signals()
func _on_AttackTwoTimer_timeout():
	emit_type_death_signals()
func _on_AttackThreeTimer_timeout():
	emit_type_death_signals()

func emit_type_death_signals() -> void:
	var id = get_instance_id()
	var inst = instance_from_id(id)
	GameEvents.emit_player_one_ran_out_of_time(inst)
	#GameEvents.emit_signal("player_one_ran_out_of_time", inst)
