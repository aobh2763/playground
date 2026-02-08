extends Control

@export var prompt_label: Label
@export var prompt_content: String
@export var options: Array[Array]      # Example: [["big"], ["today"], ["happy"]]
@export var current_level: int = 0

func _ready():
	# Initialize label with the template content
	prompt_label.text = prompt_content


func fill(i: int) -> void:
	print("called fill with i:", i)
	print("current level:", current_level)

	# Check if we have more options for current level
	if current_level >= options.size():
		print("No more fills available")
		return

	# Check if chosen index is valid
	if i < 0 or i >= options[current_level].size():
		print("Option index out of range")
		return

	var chosen_word = str(options[current_level][i])

	# Find the first remaining <fill> in the content
	var pos = prompt_content.find("<fill>")
	if pos == -1:
		print("No more <fill> tags to replace")
		return

	# Replace only the first occurrence
	prompt_content = prompt_content.substr(0, pos) + chosen_word + prompt_content.substr(pos + 6)

	# Advance level
	current_level += 1

	# Update label
	prompt_label.text = prompt_content

	print("RESULT:", prompt_content)
	print("current_level:", current_level)
