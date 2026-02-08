extends CharacterBody2D

@export var speed: float = 80.0
var direction: Vector2 = Vector2.LEFT
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Make the NPC ignore the player
	for player in get_tree().get_nodes_in_group("Player"):
		add_collision_exception_with(player)
		
	if (speed == 0):
		animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("walk")

func _physics_process(delta):
	# Move NPC
	var collision = move_and_collide(direction * speed * delta)
	
	# Reverse direction if we hit a wall
	if speed == 0:
		return
	
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Wall"):
			direction *= -1

	# Flip sprite
	$AnimatedSprite2D.flip_h = direction.x > 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body._die()
