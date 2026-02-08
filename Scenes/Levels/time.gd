extends Label

var time_started = false

func _ready() -> void:
	visible = false  # hide initially

func start_timer() -> void:
	visible = true
	time_started = true  # reset timer

func continue_timer() -> void:
	time_started = true
	
func stop_timer() -> void:
	time_started = false

func _process(delta: float) -> void:
	if time_started:
		GameState.time += delta
		text = "Time : " + str("%.2f" % GameState.time) + "s"  # 2 digits after decimal
