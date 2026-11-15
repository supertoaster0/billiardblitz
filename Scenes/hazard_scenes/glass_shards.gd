extends Area2D

func _ready() -> void:
	Sfx.play_sound("Glass")
	$AnimationPlayer.play("appear")
	$Timer.start()
	
func _on_body_entered(body: Node2D) -> void:
	if body.TOKEN_ID == "Player":
		$AnimationPlayer.play("fadeaway")
		Game.lose_health(15 + Game.DAMAGE_RECEIVE)

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("fadeaway")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fadeaway":
		queue_free()
	if anim_name == "appear":
		$AnimationPlayer.play("RESET")
