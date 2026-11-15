extends Node2D

var green = preload("res://Scenes/enemy_scenes/green_ball.tscn")
var blue = preload("res://Scenes/enemy_scenes/blue_ball.tscn")
var red = preload("res://Scenes/enemy_scenes/red_ball.tscn")
var eight_ball = preload("res://Scenes/enemy_scenes/8_ball.tscn")
@onready var player: RigidBody2D = $Player
@onready var intro: AudioStreamPlayer = $intro
@onready var loop: AudioStreamPlayer = $loop
var order = ["R", "R", "B", "B", "B", "G", "K", "K"]
var number := 0.0
var dead_enemies := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.RESET()
	$Victory.hide()
	order.shuffle()
	intro.play()

func _on_intro_finished() -> void:
	loop.play()

func _on_spawn_timer_timeout() -> void:
	if order[number] == "R":
		spawn_red()
	elif order[number] == "G":
		spawn_green()
	elif order[number] == "B":
		spawn_blue()
	elif order[number] == "K":
		spawn_8ball()
	number += 1
	if number < 8:
		reset_timer()

func _process(delta: float) -> void:
	if dead_enemies >= 8:
		$Victory.show()
		if Input.is_action_just_pressed("enter"):
			get_tree().change_scene_to_file("res://Levels/shop.tscn")

func spawn_red():
	var target = red.instantiate()
	target.Player = player
	target.position = Vector2(randi_range(240, 1000), randi_range(140, 580))
	add_child(target)

func spawn_blue():
	var target = blue.instantiate()
	target.Player = player
	target.position = Vector2(randi_range(240, 1000), randi_range(140, 580))
	add_child(target)

func spawn_green():
	var target = green.instantiate()
	target.Player = player
	target.position = Vector2(randi_range(240, 1000), randi_range(140, 580))
	add_child(target)

func spawn_8ball():
	var target = eight_ball.instantiate()
	target.Player = player
	target.position = Vector2(randi_range(240, 1000), randi_range(140, 580))
	add_child(target)

func reset_timer():
	$SpawnTimer.start()
	$SpawnTimer.wait_time = randf_range(8, 14)


func _on_loop_finished() -> void:
	$loop.play()
