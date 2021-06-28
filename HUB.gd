extends CanvasLayer

# このsignalはbuttonが押された時にstart_gameに通知するもの
signal start_game

# 何かしらのメッセージを表示するためのもの
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
# show game over
func show_game_over():
	show_message("Game Over")
	
	# message_timerのcountdownが終わるのをまつ
	yield($MessageTimer, "timeout")
	
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

# mainによってscoreが変わるたびに呼ばれる
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
