extends CanvasLayer


func _process(delta: float) -> void:
	$HPBar.value = Game.HEALTH
	$STAMINABar.value = Game.STAMINA
	$HealthLabel.text = "HEALTH " + str(Game.HEALTH) + "/" + str(Game.MAX_HEALTH)
	$StaminaLabel.text = "STAMINA " + str(int(Game.STAMINA*100)) + "/100"
