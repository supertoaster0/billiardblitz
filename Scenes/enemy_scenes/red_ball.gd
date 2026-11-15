extends RigidBody2D

@export var Player : RigidBody2D
const TOKEN_ID = "Enemy"
var state = "idle"
var direction = 0
var can_get_hit = true
var Health = 2

func _ready() -> void:
	$CollisionShape2D
	var tween = get_tree().create_tween()
	$Graphic.position.y = -position.y - 120
	tween.tween_property($Graphic, "position", Vector2(0, 0), 1.8).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	var shadowtween = get_tree().create_tween()
	$ShadowEllipse.scale = Vector2(0.1, 0.1)
	shadowtween.tween_property($ShadowEllipse, "scale", Vector2(2.2, 2.2), 0.6).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)


func look_at_player():
	direction = atan2((position.y - Player.position.y), (position.x - Player.position.x))
	direction = 180 + round((direction * 180/PI))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Graphic/HPCounter.text = str(Health)
	if state == "wind":
		var delta_x = cos(deg_to_rad(direction))
		var delta_y = sin(deg_to_rad(direction))

		position.x -= delta_x * 70 * delta
		position.y -= delta_y * 70 * delta
		
func _on_body_entered(body: Node) -> void:
	if body.TOKEN_ID == "Player" and state != "ram" and body.linear_velocity.length() > 200 and can_get_hit:
		lose_health(Game.ATK_POWER)
		Game.hit_stop(0.1)
		
	if state == "ram":
		can_get_hit = false
		$InvincibilityTimer.start()
		$AnimationPlayer.play("RESET")
		$RushTimer.stop()
		state = "idle"
		if body.TOKEN_ID == "Player":
			Game.lose_health(30 + Game.DAMAGE_RECEIVE)
		$IdleTimer.start()
		

func _on_body_exited(body: Node) -> void:
	pass # Replace with function body.

func lose_health(damage):
	Health -= Game.ATK_POWER
	if Health <= 0:
		Sfx.play_sound("Die")
		get_parent().dead_enemies += 1
		queue_free()
	else:
		Sfx.play_sound("Hit")


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("flicker")
	state = "wind"
	look_at_player()
	$WindTimer.start()


func _on_ram_timer_timeout() -> void:
	look_at_player()
	var delta_x = cos(deg_to_rad(direction))
	var delta_y = sin(deg_to_rad(direction))
	linear_velocity = Vector2(delta_x * 600, delta_y * 600)
	$RushTimer.start()
	state = "ram"


func _on_rush_timer_timeout() -> void:
	$AnimationPlayer.play("RESET")
	state = "idle"
	$IdleTimer.start()


func _on_invincibility_timer_timeout() -> void:
	can_get_hit = true
