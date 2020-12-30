extends Interactive

func _ready():
	# The main_action is (implicitly) "walk_to"
	# The secondary_action is (implicitly) ACTIONS.examine
	
	# We have to stand a couple of pixels away from it to interact
	interaction_position = self.transform.origin - Vector3(3, 0, 0)
	
	# Description
	description = "The mythical white box!"
