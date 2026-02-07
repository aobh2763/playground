extends Node2D

@onready var camera: Camera2D = $Player/Camera2D

@export var start_zoom: Vector2 = Vector2(0.25, 0.25)   # starting far
@export var target_zoom: Vector2 = Vector2(2.5, 2.5)  # final zoom
@export var zoom_speed: float = 0.05               # controls how fast it accelerates

func _ready():
	camera.zoom = start_zoom

func _process(delta):
	# Ease-in: start slow, then speed up
	var factor = delta * zoom_speed * camera.zoom.distance_to(target_zoom)
	camera.zoom = camera.zoom.lerp(target_zoom, factor)
