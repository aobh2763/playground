extends Control

@export var prompt_label: Label

@export var current_level: int

# this is a paragragh that has some annotations in it
# there is one possible annotation: <fill>
@export var prompt_content: String

# for each fill annotation, corresponds an array of strings
# => the possible words that can fill that space 
@export var options: Array[Array] = []

# <contraint>
# the number of arrays in options = the number of <fill> annotations in prompt_content
# </contraint>

func _ready():
	# initialize the label with the original content
	prompt_label.text = prompt_content

# the user will pick an option from options[current_level]
# and he will fill with it the fill annotation corresponding to that array
func fill(i: int) -> void:
	print("called fill with i: ", i)
	print(options)
	
	# Safety checks
	if current_level < 0 or current_level >= options.size():
		print("current_level out of range")
		return
	if i < 0 or i >= options[current_level].size():
		print("Option index out of range")
		return

	# Get the chosen word
	var chosen_word = str(options[current_level][i])

	# Replace the corresponding <fill> annotation
	var parts = prompt_content.split("<fill>", false)
	if current_level >= parts.size() - 1:
		print("Not enough <fill> annotations in prompt_content")
		return

	# Reconstruct the paragraph with the chosen word
	var result = ""
	for idx in range(parts.size()):
		result += parts[idx]
		if idx == current_level:
			result += chosen_word

	# Update the label
	print("resutl: ", result)
	prompt_label.text = result
