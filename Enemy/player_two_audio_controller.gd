extends Spatial

export(Resource) var runtime_data = runtime_data as RuntimeData

onready var hit_streamer = get_node("EnemyAttack")
onready var hurt_streamer = get_node("EnemyHurt")
onready var Game_streamer = get_node("EnemyStart")


var start_sounds=[]
var hit_sounds=[]
var hurt_sounds=[]
var miss_sounds=[]
var lose_game_sounds=[]
var win_game_sounds=[]
var power_up_sounds=[]


func _ready():
	GameEvents_Connect()
	add_sounds()
	randomize()

func game_ready() -> void:
	enemy_start_sound()


#Sounds
func add_sounds() -> void:

	start_sounds.append(preload("res://imports/Sound Effects/NPC Sounds/npc_game/VEGETA_0232.wav"))
	
	hit_sounds.append(preload("res://imports/Sound Effects/IMPACT Thump Thud 01.wav"))
	hit_sounds.append(preload("res://imports/Sound Effects/IMPACT Thump Thud 02.wav"))
	hit_sounds.append(preload("res://imports/Sound Effects/IMPACT Thump Thud 03.wav"))
	hit_sounds.append(preload("res://imports/Sound Effects/IMPACT Thump Thud 04.wav"))

	hurt_sounds.append(preload("res://imports/Sound Effects/NPC Sounds/npc_hit/VEGETA_0294.wav"))
	hurt_sounds.append(preload("res://imports/Sound Effects/NPC Sounds/npc_hit/VEGETA_0295.wav"))
	hurt_sounds.append(preload("res://imports/Sound Effects/NPC Sounds/npc_hit/VEGETA_0344.wav"))
	hurt_sounds.append(preload("res://imports/Sound Effects/NPC Sounds/npc_hit/VEGETA_0361.wav"))

	miss_sounds.append(preload("res://imports/Sound Effects/swing2.wav"))
	miss_sounds.append(preload("res://imports/Sound Effects/swing3.wav"))
	miss_sounds.append(preload("res://imports/Sound Effects/swing.wav"))

	win_game_sounds.append(preload("res://imports/Sound Effects/NPC Sounds/npc_game/VEGETA_0245.wav"))

	power_up_sounds.append(preload("res://imports/Sound Effects/NPC Sounds/NPC Power Up.wav"))

func enemy_start_sound() -> void:
	start_sounds.shuffle()
	Game_streamer.stream=start_sounds.front()
	Game_streamer.play()

func enemy_hit() -> void:
	hit_sounds.shuffle()
	hit_streamer.stream=hit_sounds.front()
	hit_streamer.play()
	
func enemy_miss() -> void:
	miss_sounds.shuffle()
	hit_streamer.stream=miss_sounds.front()
	hit_streamer.play()

func enemy_hurt(dead_enemy) -> void:
	hurt_sounds.shuffle()
	hurt_streamer.stream=hurt_sounds.front()
	hurt_streamer.play()

func enemy_lose() -> void:
	pass
	#start_sounds.shuffle()
	#Game_streamer.stream=start_sounds.front()
	#Game_streamer.play()
	
func enemy_win() -> void:
	pass
	win_game_sounds.shuffle()
	Game_streamer.stream=win_game_sounds.front()
	Game_streamer.play()
	
func enemy_level_up() -> void:
	power_up_sounds.shuffle()
	Game_streamer.stream=power_up_sounds.front()
	Game_streamer.play()



func GameEvents_Connect() -> void:
	GameEvents.connect("game_ready", self, "game_ready")
	GameEvents.connect("player_two_key_hit", self, "enemy_hit")
	GameEvents.connect("player_two_miss", self, "enemy_miss")
	GameEvents.connect("player_one_key_hit", self, "enemy_hurt")
	GameEvents.connect("game_lose", self, "enemy_win")
	GameEvents.connect("game_win", self, "enemy_lose")
	GameEvents.connect("game_end", self, "game_end")
	GameEvents.connect("player_two_level_up", self, "enemy_level_up")
