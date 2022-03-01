extends Spatial

onready var  hit_streamer = $PlayerOneAttack
onready var hurt_streamer = $PlayerOneHurt
onready var Game_streamer = $PlayerOneStartEnd


var start_sounds=[]
var hit_sounds=[]
var hurt_sounds=[]
var miss_sounds=[]
var lose_game_sounds=[]
var win_game_sounds=[]

func _ready():
	randomize()
	#Start Sounds Sounds
	start_sounds.append(preload("res://imports/Sound Effects/GOKU_start.wav"))
	#Hit Sounds
	hit_sounds.append(preload("res://imports/Sound Effects/IMPACT Thump Thud 01.wav"))
	hit_sounds.append(preload("res://imports/Sound Effects/IMPACT Thump Thud 02.wav"))
	hit_sounds.append(preload("res://imports/Sound Effects/IMPACT Thump Thud 03.wav"))
	hit_sounds.append(preload("res://imports/Sound Effects/IMPACT Thump Thud 04.wav"))
	hit_sounds.append(preload("res://imports/Sound Effects/SWIPE Whoosh Impact Smack Punch 04.wav"))
	hit_sounds.append(preload("res://imports/Sound Effects/SWIPE Whoosh Impact Smack Punch 05.wav"))
	#hurt sounds
	hurt_sounds.append(preload("res://imports/Sound Effects/GOKU_0083.wav"))
	hurt_sounds.append(preload("res://imports/Sound Effects/GOKU_0087.wav"))
	hurt_sounds.append(preload("res://imports/Sound Effects/GOKU_0089.wav"))
	hurt_sounds.append(preload("res://imports/Sound Effects/GOKU_0171.wav"))
	hurt_sounds.append(preload("res://imports/Sound Effects/GOKU_0166.wav"))
	#miss sounds
	miss_sounds.append(preload("res://imports/Sound Effects/swing2.wav"))
	miss_sounds.append(preload("res://imports/Sound Effects/swing3.wav"))
	miss_sounds.append(preload("res://imports/Sound Effects/swing.wav"))
	#Win Sounds
	win_game_sounds.append(preload("res://imports/Sound Effects/goku_win/GOKU_0047.wav"))
	win_game_sounds.append(preload("res://imports/Sound Effects/goku_win/GOKU_0051.wav"))
	win_game_sounds.append(preload("res://imports/Sound Effects/goku_win/GOKU_0052.wav"))
	#Lose Sounds
	lose_game_sounds.append(preload("res://imports/Sound Effects/GOKU_0166.wav"))
	lose_game_sounds.append(preload("res://imports/Sound Effects/goke_lose/GOKU_0195.wav"))
	lose_game_sounds.append(preload("res://imports/Sound Effects/goke_lose/GOKU_0197.wav"))
	
	#sounds.append(preload(""))
	GameEvents_Connect()

func GameEvents_Connect() -> void:
	GameEvents.connect("game_ready", self, "game_ready")
	GameEvents.connect("player_one_key_hit", self, "player_key_hit")
	GameEvents.connect("player_one_ran_out_of_time", self, "player_ran_out_of_time")
	GameEvents.connect("player_one_missed", self, "player_missed")
	GameEvents.connect("game_ready", self, "play_start_sound")
	GameEvents.connect("game_win", self, "game_win")
	GameEvents.connect("game_lose", self, "game_lose")
	GameEvents.connect("game_end", self, "game_end")

func play_start_sound() -> void:
	start_sounds.shuffle()
	Game_streamer.stream=start_sounds.front()
	Game_streamer.play()

func player_key_hit() -> void:
	hit_sounds.shuffle()
	hit_streamer.stream=hit_sounds.front()
	hit_streamer.play()
	
func player_missed() -> void:
	miss_sounds.shuffle()
	hit_streamer.stream=miss_sounds.front()
	hit_streamer.play()

func player_ran_out_of_time(dead_enemy) -> void:
	hurt_sounds.shuffle()
	hurt_streamer.stream=hurt_sounds.front()
	hurt_streamer.play()

func game_win() -> void:
	win_game_sounds.shuffle()
	Game_streamer.stream=win_game_sounds.front()
	Game_streamer.play()

func game_lose() -> void:
	lose_game_sounds.shuffle()
	Game_streamer.stream=lose_game_sounds.front()
	Game_streamer.play()
