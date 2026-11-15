extends Label

@onready var anim_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	anim_player.animation_finished.connect(anim_finished)
	appear()
	
func appear():
	visible = true
	anim_player.play("fadein")
	
func anim_finished(anim):
	if anim == "fadein":
		visible = true
		await get_tree().create_timer(2).timeout
		anim_player.play("fade_out")
		
	elif anim == "fade_out":
		visible = false
