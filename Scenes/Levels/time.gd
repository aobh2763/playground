extends Label

var time_started = false
var time = 0.0

func _ready() -> void:
	visible = false  # hide initially

func start_timer() -> void:
	visible = true
	time_started = true
	time = 0.0  # reset timer
	
func stop_timer() -> void:
	time_started = false

func _process(delta: float) -> void:
	if time_started:
		time += delta
		text = "Time : " + str("%.2f" % time) + "s"  # 2 digits after decimal
