extends Control

@export var next_scene: Control
@export var before_scene: Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return

	if event.is_action_pressed("ui_next") and next_scene:
		switch_to(next_scene)

	elif event.is_action_pressed("ui_before") and before_scene:
		print("switching to:", before_scene.name)
		switch_to(before_scene)
		
func switch_to(target: Control) -> void:
	visible = false
	target.visible = true
