extends Node

func play_sound(sound):
	if sound == "Hit":
		$hit.play()
	if sound == "Die":
		$die.play()
	if sound == "Hurt":
		$hurt.play()
	if sound == "Heal":
		$heal.play()
	if sound == "Upgrade":
		$upgrade.play()
	if sound == "Glass":
		$glass.play()
