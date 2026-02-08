extends CharacterBody2D

@export var speed: float = 80.0
@export var horizontal: bool = true   # True = move horizontally, False = move vertically

var direction: Vector2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Make the NPC ignore the player
	for player in get_tree().get_nodes_in_group("Player"):
		add_collision_exception_with(player)
	
	# Set initial direction based on movement type
	if (horizontal):
		direction = Vector2.LEFT
	else:
		direction = Vector2.UP

	if speed == 0:
		animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("walk")


func _physics_process(delta):
	# Move NPC
	var collision = move_and_collide(direction * speed * delta)
	
	if speed == 0:
		return
	
	# Reverse direction if we hit a wall
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Wall"):
			direction *= -1

	# Flip sprite if horizontal movement
	if horizontal:
		$AnimatedSprite2D.flip_h = direction.x > 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body._die()
