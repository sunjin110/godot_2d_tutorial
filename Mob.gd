extends RigidBody2D


# Declare member variables here. Examples:
export var min_speed = 150
export var max_speed = 250

# Called when the node enters the scene tree for the first time.
func _ready():
	# 3つのアニメーションからランダムに選択
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	
# Mobが画面を離れた時にモブを削除する
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

