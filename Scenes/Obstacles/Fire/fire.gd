extends Area2D

@export var on_duration: float = 1.0
@export var off_duration: float = 1.5

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

var active := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_off_state()

func set_off_state():
	active = false
	sprite.play("off")
	collision.disabled = true

	timer.start(off_duration)
	timer.timeout.connect(set_on_state, CONNECT_ONE_SHOT)

func set_on_state():
	active = true
	sprite.play("on")
	collision.disabled = false

	timer.start(on_duration)
	timer.timeout.connect(set_off_state, CONNECT_ONE_SHOT)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if not active:
		print("not active")
		return
	if body.is_in_group("Player"):
		body._die()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player exited spike")
		sprite.play("off")
