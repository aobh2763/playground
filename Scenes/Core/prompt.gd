extends Control

@export var prompt_label: Label
@export var options: Array[Array]      # Example: [["big"], ["today"], ["happy"]]

func _ready():
	# Initialize label with the template content
	prompt_label.text = GameState.prompt_content


func fill(i: int) -> void:
	print("called fill with i:", i)
	print("current level:", GameState.current_level)

	# Check if we have more options for current level
	if GameState.current_level >= options.size():
		print("No more fills available")
		return

	# Check if chosen index is valid
	if i < 0 or i >= options[GameState.current_level].size():
		print("Option index out of range")
		return

	var chosen_word = str(options[GameState.current_level][i])

	# Find the first remaining <fill> in the content
	var pos = GameState.prompt_content.find("____")
	if pos == -1:
		print("No more <fill> tags to replace")
		return

	# Replace only the first occurrence
	GameState.prompt_content = GameState.prompt_content.substr(0, pos) + chosen_word + GameState.prompt_content.substr(pos + 4)

	# Advance level
	GameState.current_level += 1

	# Update label
	prompt_label.text = GameState.prompt_content

	print("RESULT:", GameState.prompt_content)
	print("GameState.current_level", GameState.current_level)
