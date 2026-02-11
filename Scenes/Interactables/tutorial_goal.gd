extends Area2D

@export var next_scene: String
@onready var sprite = $AnimatedSprite2D
@export var option_idx = 0

@onready var timer: Label = $"../../Player/Time"

@onready var label: Label = $Label

func _ready():
	sprite.animation = "idle"
	sprite.play()
	
	label.text = GameState.tutorial_options[0][option_idx]

func start_new_scene(scene):
	get_tree().change_scene_to_file(scene)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("player entered")
		var ui := get_tree().get_first_node_in_group("PromptUI")
		if ui:
			ui.fill(option_idx)
			start_new_scene(next_scene)
			timer.stop_timer()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("player entered")
