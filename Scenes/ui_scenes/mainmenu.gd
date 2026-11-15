extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$music.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level1.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_music_finished() -> void:
	$music.play()
