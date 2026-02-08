extends Node2D

@onready var camera: Camera2D = $Player/Camera2D
@onready var player: PlayerMain = $Player
@onready var time: Label = $Player/Time

@export var start_zoom: Vector2 = Vector2(0.2, 0.2)   # starting far
@export var target_zoom: Vector2 = Vector2(0.8, 0.8)  # final zoom
@export var zoom_duration: float = 1.0                # total zoom time in seconds
@export var delay_before_zoom: float = 1.0           # delay before zoom starts

var elapsed_time: float = 0.0
var zooming: bool = false
var delay_elapsed: float = 0.0
var zoom_started: bool = false

func _ready():
	camera.zoom = start_zoom
	zooming = false
	delay_elapsed = 0.0
	zoom_started = false

func _process(delta):
	# Phase 1: delay before zoom
	if not zoom_started:
		delay_elapsed += delta
		if delay_elapsed >= delay_before_zoom:
			zooming = true
			zoom_started = true
			elapsed_time = 0.0  # reset zoom timer
		return  # do nothing else during delay

	# Phase 2: zoom
	if zooming:
		elapsed_time += delta
		var t = clamp(elapsed_time / zoom_duration, 0, 1)
		var ease_factor = pow(t, 2)  # ease-in interpolation
		camera.zoom = start_zoom.lerp(target_zoom, ease_factor)

		# Finish zoom
		if elapsed_time >= zoom_duration:
			camera.zoom = target_zoom
			zooming = false
			# Enable player movement
			player.fsm.current_state.set_can_move(true)
			# Start the timer label
			time.start_timer()
