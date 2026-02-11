extends Control

@export var win_label_1: Label
@export var win_label_2: Label

func _ready() -> void:
	win_label_1.text = "You win!"
	win_label_2.text = "Prompt Generated in " + str("%.2f" % GameState.time) + "s"
