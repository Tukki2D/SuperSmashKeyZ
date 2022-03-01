extends Node2D

var hit_animator = preload("res://coding_art_assets/hit_sprites.tscn")
onready var Enemy_Gets_Hit  = get_node("Hit_Effects_Right")
onready var Player_Gets_Hit  = get_node("Hit_Effects_Left")

func _ready() -> void:
	GameEvents.connect("player_one_key_hit", self, "player_one_key_hit")
	GameEvents.connect("player_two_key_hit", self, "player_two_key_hit")
	
func player_one_key_hit() -> void:
	var animator = hit_animator.instance()
	add_child(animator)
	play_random_animation(animator)
	set_animation_size_and_angle(animator, Enemy_Gets_Hit)

func player_two_key_hit() -> void:
	var animator = hit_animator.instance()
	add_child(animator)
	play_random_animation(animator)
	set_animation_size_and_angle(animator, Player_Gets_Hit)

	
func play_random_animation(animation_player:AnimatedSprite):
	randomize()
	var list = ["anim_hit_circle", "anim_hit_spark", "anim_hit_sphere", "anim_hit_star"]
	list.shuffle()
	var animationName = list[0]
	animation_player.play(animationName)


func set_animation_size_and_angle(animator: AnimatedSprite, spawner : Node2D) -> void:
	randomize()
	animator.scale.x = rand_range(1, 2)
	animator.scale.y = rand_range(1, 2)

	var _position_object = round(rand_range(0, spawner.get_child_count()-1))
	_position_object = spawner.get_child(_position_object)
	animator.position = _position_object.position
	#set rotation
	animator.look_at(self.position)
	animator.rotation_degrees+=180
