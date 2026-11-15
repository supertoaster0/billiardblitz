extends RigidBody2D

const TOKEN_ID = "Player"
var stamina_timer := 0.0
var slowed = false

func _ready() -> void:
	if "GlassBullet" in Game.picked_upgrades:
		Game.ATK_POWER = max(Game.ATK_POWER, 2)
		Game.DAMAGE_RECEIVE = max(Game.ATK_POWER, 10)

func _process(delta: float) -> void:
	if Game.STAMINA < 1.0:
		stamina_timer += delta
		if stamina_timer >= 1.0 and Game.player_state != "focus":
			stamina_timer = 0.0
			Game.STAMINA += 0.25

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Game.STAMINA >= 0.5:
		Engine.time_scale = Game.FOCUS
		Game.player_state = "focus"
	if Game.player_state == "focus" and not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Engine.time_scale = 1
		linear_velocity = position - Game.focus_point
		linear_velocity *= Game.SPEED
		if slowed:
			linear_velocity *= 0.4
		Game.player_state = "idle"
		Game.STAMINA -= 0.5
	queue_redraw()

func _draw():
	if Game.player_state == "focus":
		var start_point = Vector2(0, 0)
		var end_point = to_local(get_global_mouse_position())
		var size_limit = (end_point - start_point).limit_length(Game.RANGE)
		end_point = start_point + size_limit
		draw_line(start_point, end_point, Color(Color.WHITE, 0.8), 28)
		Game.focus_point = to_global(end_point)
	if "Oracle" in Game.picked_upgrades and Game.player_state == "focus":
		var start_point = Vector2(0, 0)
		var end_point = to_local(get_global_mouse_position())
		draw_line(start_point, -end_point, Color(Color.WHITE, 0.3), 13)


func _on_body_entered(body: Node) -> void:
	if body.TOKEN_ID == "Enemy" and "Shockwave" in Game.picked_upgrades:
		pass
