extends Node

var target_scene: PackedScene
var player_state = "idle"
var focus_point : Vector2
var SPEED := 3.2
var RANGE := 260
var ATK_POWER := 1
var RESILIENCE := 2.0
var FOCUS = 0.4
var FRICTION = 0.7
var HEALTH := 100
var MAX_HEALTH = 100
var STAMINA := 1.0
var DAMAGE_RECEIVE = 0
var Coins = 0
var level = 1
var upgrade_cards = [
	"GlassBullet",
	"ChainReaction",
	"HelpingHand",
	"Oracle",
	"Parry",
	#"Shockwave",
	#"Stopwatch",
]
var slot_machine_cards = [
	"GlassBullet",
	"ChainReaction",
	"HelpingHand",
	"Oracle",
	"Parry",
	#"Shockwave",
#"Stopwatch",
]
var picked_upgrades = []

"""
git add .
git commit -m "Shop finally working"
git push
"""

func _ready() -> void:
	FULLRESET()

func lose_health(damage):
	print(damage)
	Sfx.play_sound("Hurt")
	HEALTH -= damage

	print(HEALTH)
	if "Parry" in picked_upgrades:
		STAMINA += 0.5
		STAMINA = min(1, STAMINA)
	
	if HEALTH <= 0:
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://Scenes/ui_scenes/gameover.tscn")
		
func hit_stop(time):
	get_tree().paused = true
	await get_tree().create_timer(time).timeout
	get_tree().paused = false

func RESET():
	HEALTH = MAX_HEALTH
	STAMINA = 1.0

func FULLRESET():
	upgrade_cards = [
	"GlassBullet",
	"ChainReaction",
	"HelpingHand",
	"Oracle",
	"Parry",
	#"Shockwave",
	#"Stopwatch",
]
	picked_upgrades.clear()
	HEALTH = MAX_HEALTH
	level = 1

func reset_slot_machine():
	slot_machine_cards = upgrade_cards.duplicate()

func next_level():
	level += 1
	if level == 1:
		get_tree().change_scene_to_file("res://Levels/level1.tscn")
	if level == 2:
		get_tree().change_scene_to_file("res://Levels/level2.tscn")
	if level == 3:
		get_tree().change_scene_to_file("res://Levels/level3.tscn")
	if level == 4:
		get_tree().change_scene_to_file("res://Levels/level4.tscn")
	if level == 5:
		get_tree().change_scene_to_file("res://Levels/level5.tscn")
