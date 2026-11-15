extends Area2D

@export var title : String
var is_touching_mouse := false
var index = 0
var tween

func _ready() -> void:
	$Timer.wait_time = 2 + index * 0.6
	$Timer.start()

func _process(delta: float) -> void:
	if is_touching_mouse:
		$Sprite2D.scale = Vector2(1.2, 1.2)
		if Input.is_action_just_pressed("click"):
			Sfx.play_sound("Upgrade")
			Game.picked_upgrades.append(title)
			Game.upgrade_cards.erase(title)
			Game.next_level()
	else:
		$Sprite2D.scale = Vector2(1, 1)

func _on_mouse_entered() -> void:
	is_touching_mouse = true


func _on_mouse_exited() -> void:
	is_touching_mouse = false


func _on_timer_timeout() -> void:
	tween = create_tween()
	tween.tween_property(self, "position", Vector2(position.x, 360.0), 0.4).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	$Sprite2D.play(title)
