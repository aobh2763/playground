extends State
class_name PlayerWalking

@export var movespeed := int(350)
@export var dash_max := int(500)
var dashspeed := float(100)
var can_dash := bool(false)
var dash_direction := Vector2(0,0)

var player : CharacterBody2D
@export var animator : AnimationPlayer

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	animator.play("WalkForwards")

func Update(delta : float):
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	Move(input_dir)
	LessenDash(delta)

	if(Input.is_action_just_pressed("Dash") && can_dash):
		start_dash(input_dir)
		
	if Input.is_action_just_pressed("Punch") or Input.is_action_just_pressed("Kick"):
		Transition("Attacking")
	
func Move(input_dir : Vector2):
	# Cancel dash if input changes mid-dash
	if dash_direction != Vector2.ZERO and dash_direction != input_dir:
		dash_direction = Vector2.ZERO
		dashspeed = 0

	# Get sprite node
	var sprite = player.get_node("AnimatedSprite2D")  # or Sprite2D

	# Handle left/right flipping
	if input_dir.x > 0:
		sprite.flip_h = false
	elif input_dir.x < 0:
		sprite.flip_h = true

	# Determine animation based on movement direction
	if input_dir.length() > 0:
		if abs(input_dir.x) > abs(input_dir.y):
			# Moving mostly horizontally
			if animator.current_animation != "Walk":
				animator.play("Walk")
		else:
			# Moving mostly vertically
			if animator.current_animation != "WalkForwards":
				animator.play("WalkForwards")
	else:
		# No input → go to idle
		Transition("Idle")

	# Apply movement
	player.velocity = input_dir * movespeed + dash_direction * dashspeed 
	
	if player.move_and_slide():
		var collision := player.get_slide_collision(0)
		var body := collision.get_collider() as RigidBody2D
		if body:
			body.apply_central_impulse(
				-collision.get_normal() * 20.0
			)
func start_dash(input_dir : Vector2):
	AudioManager.play_sound(AudioManager.PLAYER_ATTACK_SWING, 0.3, -1)
	dash_direction = input_dir.normalized()
	dashspeed = dash_max
	animator.play("Dash")
	can_dash = false

func LessenDash(delta : float):
	#Higher multiplier values makes the dash shorter
	var multiplier : float = 4.0
	var timemultiplier : float = 4.1
	
	#slow down the dash over time, both as a fraction of dashspeed and also time
	#While clamping it between 0 and dash_max
	dashspeed -= (dashspeed * multiplier * delta) + (delta * timemultiplier)
	dashspeed = clamp(dashspeed, 0, dash_max)
	
	if(dashspeed <= 0):
		can_dash = true
		dash_direction = Vector2.ZERO
		
	if(animator.current_animation == "Dash"):
		await animator.animation_finished
		animator.play("WalkForwards")

#We cannot allow a transition before the dash is complete and the animation has stopped playing
func Transition(newstate : String):
	if(dashspeed <= 0):
		state_transition.emit(self, newstate)
