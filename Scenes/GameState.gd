extends Node

var tutorial_prompt_content := "Hello, ____!"
var tutorial_options := [
	["World", "Sailor"]
]

var prompt_content := "Communism ____ freedom and ____ innovation by centralizing economic control for ____."
var options := [
	["promotes", "reshapes", "restricts", "suppresses"],
	["channels", "redirects", "stifles", "redefines"],
	["equality", "solidarity", "stability", "dominance"]
]

var current_level := -1

func is_tutorial() -> bool:
	return current_level == -1

var time: float = 0.0
var current_intro_scene = 0
