extends RigidBody2D

@export var Player : RigidBody2D

const TOKEN_ID = "Enemy"
var Health = 4
@onready var hp_counter: Label = $Graphic/HPCounter
var shards = preload("res://Scenes/hazard_scenes/glass_shards.tscn")
var direction = 0
var state = "normal"

@onready var shardstimer: Timer = $shardstimer
@onready var move_timer: Timer = $move_timer

func _ready():
	shardstimer.wait_time = randi_range(5, 7)
	shardstimer.start()
	
	var tween = get_tree().create_tween()
	$Graphic.position.y = -position.y - 120
	tween.tween_property($Graphic, "position", Vector2(0, 0), 1.8).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	var shadowtween = get_tree().create_tween()
	$ShadowEllipse.scale = Vector2(0.1, 0.1)
	shadowtween.tween_property($ShadowEllipse, "scale", Vector2(2, 2), 0.6).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)

func _process(delta: float) -> void:
	hp_counter.text = str(Health)
	if state == "move":
		look_at_player()
			
		var delta_x = cos(deg_to_rad(direction))
		var delta_y = sin(deg_to_rad(direction))
		
		linear_velocity = Vector2(delta_x * 50, delta_y * 50)

func look_at_player():
	direction = atan2((position.y - Player.position.y), (position.x - Player.position.x))
	direction = 180 + round((direction * 180/PI))

func _on_body_entered(body: Node) -> void:
	if body.TOKEN_ID == "Player" and body.linear_velocity.length() > 120:
		lose_health(Game.ATK_POWER)
		state = "normal"
		Game.hit_stop(0.1)


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

func _on_shardstimer_timeout() -> void:
	var new_shards = shards.instantiate()
	new_shards.position = position
	shardstimer.wait_time = randi_range(5, 7)
	shardstimer.start()
	$"..".add_child(new_shards)

func _on_move_timer_timeout() -> void:
	state = "move"
