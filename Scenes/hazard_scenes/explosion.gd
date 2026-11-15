extends Area2D

func _ready() -> void:
	$CPUParticles2D.emitting = true

func _on_body_entered(body: Node2D) -> void:
	if body.TOKEN_ID == "Enemy":
		body.lose_health(1)


func _on_cpu_particles_2d_finished() -> void:
	queue_free()
