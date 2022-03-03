extends Spatial

onready var menu = preload("res://scenes/win_lose_menu/win_lose_menu.tscn")
onready var WordArtAsset  = get_node("FightSprites/WordArtAsset")
onready var DebugPlayerSprites  = get_node("FightSprites/Viewport/CameraStand/DebugSprites")

func _ready() -> void:
	GameEvents.connect("game_end", self, "game_end")
	GameEvents.connect("game_ready", self, "game_ready")
	GameEvents.connect("game_start", self, "game_start")
	WordArtAsset.visible = true
	DebugPlayerSprites.visible = false


func game_ready() -> void:
	WordArtAsset.visible = true
	DebugPlayerSprites.visible = true


func game_end() -> void:
	WordArtAsset.visible = false
	DebugPlayerSprites.visible = false
	var _menu = menu.instance()
	add_child(_menu)
