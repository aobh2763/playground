extends Area2D

@export var start_angle = 45
@export var end_angle = -45
@export var direction = 1

func _ready():
	var tween := create_tween()
	tween.set_loops()
	if direction == 1:
		tween.tween_property(self, "rotation", deg_to_rad(start_angle), 3.0)
		tween.tween_property(self, "rotation", deg_to_rad(end_angle), 3.0)
	else:
		tween.tween_property(self, "rotation", deg_to_rad(end_angle), 3.0)
		tween.tween_property(self, "rotation", deg_to_rad(start_angle), 3.0)
		



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body._die()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("player exited")
