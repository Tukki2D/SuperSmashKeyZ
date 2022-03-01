extends Timer

export(Resource) var runtime_data = runtime_data as RuntimeData

export var countdown_to_start = 3

func _ready() -> void:
	GameEvents.connect("game_ready", self, "game_ready")

func game_ready() -> void:
	runtime_data.current_gameplay_state = Enums.GameplayState.READY
	self.start(countdown_to_start)
