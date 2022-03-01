extends AudioStreamPlayer

export(Resource) var runtime_data = runtime_data as RuntimeData

var Play_Music = preload("res://imports/DBZM-M1307.mp3")
var Win_Music  = preload("res://imports/DBZSongMP3.mp3")
var Lose_Music = preload("res://imports/DBZ-Lose.mp3")

func _ready() -> void:
	connect_to_game_events()
	set_stream(Play_Music)
	play()
	
func game_ready() -> void:
	set_stream(Play_Music)
	play()

func game_win() -> void:
	set_stream(Win_Music)
	play()

func game_lose() -> void:
	set_stream(Lose_Music)
	play()

func connect_to_game_events() -> void:
	GameEvents.connect("game_ready", self, "game_ready")
	GameEvents.connect("game_end", self, "game_end")
	GameEvents.connect("game_win", self, "game_win")
	GameEvents.connect("game_lose", self, "game_lose")
