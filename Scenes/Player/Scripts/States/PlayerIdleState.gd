extends State
class_name PlayerIdle

@export var animator : AnimationPlayer

var can_move = false

func set_can_move(new_value):
	can_move = new_value

func Enter():
	animator.play("Idle")
	pass
	
func Update(_delta : float):
	if !can_move:
		return
	
	if(Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()):
		state_transition.emit(self, "Moving")
		
	if Input.is_action_just_pressed("Punch")  or Input.is_action_just_pressed("Kick"):
		state_transition.emit(self, "Attacking")
