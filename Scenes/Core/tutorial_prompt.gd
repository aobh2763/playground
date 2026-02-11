extends Control

@export var prompt_label: Label

func _ready():
	# Initialize label with the template content
	prompt_label.text = GameState.tutorial_prompt_content


func fill(i: int) -> void:
	print("called fill with i:", i)
	print("current level:", 0)

	# Check if chosen index is valid
	if i < 0 or i >= GameState.tutorial_options[0].size():
		print("Option index out of range")
		return

	var chosen_word = str(GameState.tutorial_options[0][i])

	# Find the first remaining <fill> in the content
	var pos = GameState.tutorial_prompt_content.find("____")
	if pos == -1:
		print("No more <fill> tags to replace")
		return

	# Replace only the first occurrence
	GameState.tutorial_prompt_content = GameState.tutorial_prompt_content.substr(0, pos) + chosen_word + GameState.tutorial_prompt_content.substr(pos + 4)

	# Update label
	prompt_label.text = GameState.tutorial_prompt_content

	print("RESULT:", GameState.tutorial_prompt_content)
