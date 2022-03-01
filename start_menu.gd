extends Spatial

export(Resource) var runtime_data = runtime_data as RuntimeData

onready var next_scene = preload("res://scenes/fight_scene/fight_scene.tscn")


export (Color) var blue = Color("#4682b4")
export (Color) var green = Color("#639765")
export (Color) var red = Color("#a65455")

onready var animator = get_node("Black_Canvas/AnimationPlayer")
onready var prompt = get_node("TypeSpace")
onready var key_streamer = get_node("SoundPlayer")
onready var menu_streamer = get_node("MenuMusic")

onready var prompt_text = prompt.text
var next_character = 0
var current_letter_index = 0

var hit_sounds=[]
var miss_sounds=[]


func _ready() -> void:
	load_sounds()
	GameEvents.connect("debug_key", self, "debug_key")
	


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var typed_event = event as InputEventKey
		var key_typed = PoolByteArray([typed_event.unicode]).get_string_from_utf8()
		
		var next_character = prompt_text.substr(current_letter_index, 1)
		if key_typed == next_character:
			proceed_to_next_key_character()
			player_key_hit()
			if current_letter_index == prompt_text.length():
				reached_end_of_type_text()
		else:
			print("incorrectly typed %s instead of %s" % [key_typed, next_character])

func player_key_hit() -> void:
	hit_sounds.shuffle()
	key_streamer.stream=hit_sounds.front()
	key_streamer.play()
	
func player_missed() -> void:
	miss_sounds.shuffle()
	key_streamer.stream=miss_sounds.front()
	key_streamer.play()

func proceed_to_next_key_character() -> void:
	GameEvents.emit_signal("key_hit")
	current_letter_index += 1
	set_next_character(current_letter_index)

func reached_end_of_type_text() -> void:
	transition()
	
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


func transition() -> void:
	animator.play("fade_to_black_anim")
	menu_streamer.volume_db = lerp(menu_streamer.volume_db, -15, 0.1)


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/fight_scene/fight_scene.tscn")
	print("From Start Menu: Changing Scene")
	queue_free()


func load_sounds() -> void:
	hit_sounds.append(preload("res://imports/Sound Effects/IMPACT Thump Thud 01.wav"))
	hit_sounds.append(preload("res://imports/Sound Effects/IMPACT Thump Thud 02.wav"))
	hit_sounds.append(preload("res://imports/Sound Effects/IMPACT Thump Thud 03.wav"))
	hit_sounds.append(preload("res://imports/Sound Effects/IMPACT Thump Thud 04.wav"))
	miss_sounds.append(preload("res://imports/Sound Effects/swing2.wav"))
	miss_sounds.append(preload("res://imports/Sound Effects/swing3.wav"))
	miss_sounds.append(preload("res://imports/Sound Effects/swing.wav"))


#Debug Key
func debug_key() -> void:
	transition()
	print("From Start Menu: Debug Key Pressed ++ Transitioning Scene")
