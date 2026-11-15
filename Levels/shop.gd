extends Node

var upgradecard = preload("res://Scenes/ui_scenes/upgrade_card.tscn")
var y_offset = 0
var reached_rank = -1
var slot_stop 

func draw_card(index):
	var card = upgradecard.instantiate()
	card.position = Vector2(640-300 + index*300, 1000)
	var random = Game.slot_machine_cards.pick_random()
	Game.slot_machine_cards.erase(random)
	card.title = random
	card.index = index
	add_child(card)

func _ready() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Sprite2D, "modulate", Color(1, 1, 1, 1), 0.7).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($Sprite2D2, "modulate", Color(1, 1, 1, 1), 0.7).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($Sprite2D3, "modulate", Color(1, 1, 1, 1), 0.7).set_trans(Tween.TRANS_CUBIC)

func _process(delta: float) -> void:
	y_offset += delta*3
	if reached_rank != -1:
		if reached_rank < 1:
			$Sprite2D.material.set_shader_parameter("y_offset", y_offset)
		else:
			$Sprite2D.material.set_shader_parameter("y_offset", 0.175)
		if reached_rank < 2:
			$Sprite2D2.material.set_shader_parameter("y_offset", y_offset+6)
		else:
			$Sprite2D2.material.set_shader_parameter("y_offset", 0.175)
		if reached_rank < 3:
			$Sprite2D3.material.set_shader_parameter("y_offset", y_offset+2)
		else:
			$Sprite2D3.material.set_shader_parameter("y_offset", 0.175)



func _on_timer_timeout() -> void:
	if reached_rank < 3:
		$Timer.wait_time = 0.55
		$Timer.start()
	reached_rank += 1


func _on_initial_timer_timeout() -> void:
	reached_rank = 0
	for i in 3:
		draw_card(i)
	$Timer.start()
