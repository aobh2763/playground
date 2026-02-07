extends CharacterBody2D

@export var speed: float = 80.0
var direction: Vector2 = Vector2.LEFT

func _ready():
	# Make the NPC ignore the player
	for player in get_tree().get_nodes_in_group("Player"):
		add_collision_exception_with(player)
		

func _physics_process(delta):
	# Move NPC
	var collision = move_and_collide(direction * speed * delta)
	
	# Reverse direction if we hit a wall
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Wall"):
			direction *= -1

	# Flip sprite
	$Sprite2D.flip_h = direction.x > 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body._die()
