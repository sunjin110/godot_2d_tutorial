extends Node

# TODO 下記の手順で仕上げで手を入れたいよね!
# https://docs.godotengine.org/ja/stable/getting_started/step_by_step/your_first_game.html

# Declare member variables here. Examples:
export (PackedScene) var Mob
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# gameが終了するもの
# hitからsignalを取得して、シグナルが来たら動くようにする
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	# show game over
	$HUB.show_game_over()
	
	# delete mobs
	get_tree().call_group("mobs", "queue_free")
	
# new game
func new_game():
	score = 0
	$Player.start($StartPositon.position)
	$StartTimer.start()
	
	# HUB
	$HUB.update_score(score)
	$HUB.show_message("Get Ready")

# start_timeが終わってから発動するもの
# start_timerはone_shot
func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
# score_timerがclockするタイミングで呼ばれるもの
func _on_ScoreTimer_timeout():
	score += 1
	$HUB.update_score(score)

# mob_timerがclockするタイミングで呼ばれるもの
func _on_MobTimer_timeout():
	# choose a random location on path2d
	$MobPath/MobSpawnLocation.offset = randi()
	# create a mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# 進行方向をpathと垂直に設定
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	mob.position = $MobPath/MobSpawnLocation.position
	
	# Add some randomness to the direction
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	
	# set velocity (speed & direction
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)

	
