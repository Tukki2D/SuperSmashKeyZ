extends ViewportContainer

onready var camera_stand = get_node("Viewport/CameraStand")
onready var camera = get_node("Viewport/CameraStand/CharacterCamera")
onready var WordArt = get_node("WordArtAsset")

onready var camera_x = camera_stand.translation.x
onready var camera_y = camera_stand.translation.y


func _ready() -> void:
	GameEvents.connect("player_two_key_hit", self, "hit")
	GameEvents.connect("player_one_key_hit", self, "hit")
	
func hit() -> void:
	camera.translation.x = camera_x + rand_range(-0.25, 0.25)
	camera.translation.y = camera_y + rand_range(-0.25, 0.25)
