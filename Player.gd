extends Area2D

# 当たり判定
signal hit

# valiable
export var speed = 400 # player speed (pixels/sec)
var screen_size # game window

# Called when the node enters the scene tree for the first time.
# nodeがシーンに入る時に呼ばれるもの
func _ready():
	screen_size = get_viewport_rect().size
	
	# game start時は表示されないようにする
	hide()

# playerが何をするか？を定義するところ
# frameごとに呼ばれる
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	# update player positon
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# animation
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_h = false
		

	
# あたり判定
func _on_Player_body_entered(body):
	hide() # hitした後は、playerは消える
	emit_signal("hit") # 2回目にhitしないようにする
	$CollisionShape2D.set_deferred("disabled", true) # 当たり判定を殺す
	
	
# start
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
