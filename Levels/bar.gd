extends Node2D

var drinks = [
	"Bloody Mary", "Grass Hopper", "Pina Colada", "Martini", "Cider", "Champagne"
]
var descriptions = {
	"Bloody Mary" : "+1 ATK - 8 GOLD",
	"Grass Hopper" : "+40 HP - 5 COLD",
	"Pina Colada" : "Complete focus - 10 GOLD",
	"Martini" : "No friction - 2 GOLD",
	"Cider" : "Faster Speed - 6 GOLD",
	"Champagne" : "More Range - 3 GOLD",
}

var selected = ""
var clicks = 0

func _on_bloody_mary_pressed() -> void:
	$Title.text = drinks[0]
	$Title2.text = descriptions[$Title.text]
	if selected == $Title.text:
		clicks += 1
		if clicks == 1:
			if Game.Coins > 8:
				Game.ATK_POWER += 1
				Game.Coins -= 8
			else:
				print("Tung")
				$Title.text = "NOT ENOUGH MONEY"
		selected = $Title.text
	else:
		clicks = 0

func _on_champagne_pressed() -> void:
	if Game.Coins > 3:
		Game.RANGE += 30
		Game.Coins -= 5
	$Title.text = drinks[5]
	$Title2.text = descriptions[$Title.text]

func _on_cider_pressed() -> void:
	if Game.Coins > 6:
		Game.SPEED += 0.6
		Game.Coins -= 6
	$Title.text = drinks[4]
	$Title2.text = descriptions[$Title.text]

func _on_grasshopper_pressed() -> void:
	if Game.Coins > 5:
		Game.MAX_HEALTH = 40
		Game.Coins -= 5
	$Title.text = drinks[1]
	$Title2.text = descriptions[$Title.text]

func _on_martini_pressed() -> void:
	if Game.Coins > 2:
		Game.FRICTION += 0.1
		Game.Coins -= 2
	$Title.text = drinks[3]
	$Title2.text = descriptions[$Title.text]

func _on_pina_colada_pressed() -> void:
	if Game.Coins > 10:
		Game.FOCUS -= 0.1
		Game.FOCUS = max(Game.FOCUS, 0)
		Game.Coins -= 10
	$Title.text = drinks[2]
	$Title2.text = descriptions[$Title.text]
