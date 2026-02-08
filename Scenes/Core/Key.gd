extends Area2D

func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player picked the key!")

		# Remove the first door in the "Door" group
		var doors = get_tree().get_nodes_in_group("Door")
		if doors.size() > 0:
			var first_door = doors[0]
			first_door.queue_free()  # Remove the door
			print("Removed first door in group")
		else:
			print("No doors left to remove")

		# Remove the key itself
		queue_free()
		print("Key has been removed after use")


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player left the key area")
