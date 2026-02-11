extends Control

const FILL_TOKEN := "____"

@export var prompt_label: Label

func _ready() -> void:
	_update_prompt()

func fill(i: int) -> void:
	if GameState.is_tutorial():
		_fill_tutorial(i)
		return  # CRITICAL: stop normal logic

	_fill_normal(i)

func _fill_normal(i: int) -> void:
	var level := GameState.current_level

	if level < 0 or level >= GameState.options.size():
		print("Invalid level")
		return

	if i < 0 or i >= GameState.options[level].size():
		print("Option index out of range")
		return

	var pos := GameState.prompt_content.find(FILL_TOKEN)
	if pos == -1:
		print("No more fills")
		return

	var chosen := str(GameState.options[level][i])

	GameState.prompt_content = (
		GameState.prompt_content.substr(0, pos)
		+ chosen
		+ GameState.prompt_content.substr(pos + FILL_TOKEN.length())
	)

	GameState.current_level += 1
	_update_prompt()

func _fill_tutorial(i: int) -> void:
	if i < 0 or i >= GameState.tutorial_options[0].size():
		print("Tutorial option index out of range")
		return

	var pos := GameState.tutorial_prompt_content.find(FILL_TOKEN)
	if pos == -1:
		print("Tutorial finished")
		return

	var chosen := str(GameState.tutorial_options[0][i])

	GameState.tutorial_prompt_content = (
		GameState.tutorial_prompt_content.substr(0, pos)
		+ chosen
		+ GameState.tutorial_prompt_content.substr(pos + FILL_TOKEN.length())
	)

	GameState.current_level += 1
	_update_prompt()

func _update_prompt() -> void:
	if GameState.is_tutorial():
		prompt_label.text = GameState.tutorial_prompt_content
	else:
		prompt_label.text = GameState.prompt_content
