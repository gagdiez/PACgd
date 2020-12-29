extends Interactive

func _ready():
	# We can take this object
	main_action = ACTIONS.take
	
	# The secondary_action is (implicitly) ACTIONS.examine

	# We have to stand a couple of pixels away from it to interact
	interaction_position = self.transform.origin + Vector3(3, 0, 0)

	# Description and Thumbnail
	description = "The box I have to move"
	thumbnail = "res://thumbnails/red_box.png"
