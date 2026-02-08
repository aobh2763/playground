extends Area2D

@onready var sprite = $AnimatedSprite2D
@export var option_idx = 0

func _ready():
	sprite.animation = "idle"
	sprite.play()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("player entered")
		var ui := get_tree().get_first_node_in_group("PromptUI")
		if ui:
			ui.fill(option_idx)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("player entered")
