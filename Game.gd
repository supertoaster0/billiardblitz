extends Node

var player_state = "idle"
var focus_point : Vector2
var SPEED := 3.2
var RANGE := 260
var ATK_POWER := 1
var RESILIENCE := 2.0
var HEALTH := 100
var MAX_HEALTH = 100
var STAMINA := 1.0

"""
git add .
git commit -m "Commit name"
git push
"""

func lose_health(damage):
	Sfx.play_sound("Hurt")
	HEALTH -= damage
	if HEALTH <= 0:
		print("GAMEOVER")
		
func hit_stop(time):
	get_tree().paused = true
	await get_tree().create_timer(time).timeout
	get_tree().paused = false

func RESET():
	HEALTH = MAX_HEALTH
	STAMINA = 1.0
