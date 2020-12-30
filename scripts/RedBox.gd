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

func use_item(who, what):
	# Since we only have one other element in the screen, <what> will be
	# the WHITE box
	
	who.approach(what)
	who.face_object(what)
	who.say("Time to place one box on top of the other")
	who.animate_until_finished("raise_hand")
	who.remove_from_inventory(self)
	who.interact(self, "place_over", [what])
	who.animate_until_finished("lower_hand")
	who.say("That is it, thank you for playing")

func place_over(box):
	# Function called by who.interact(self, "place_box")
	# Place the box on top of the WHITE one
	self.transform.origin = box.transform.origin + Vector3(0, 2, 0)
	self.visible = true
	
	# Disable interactions with the white box
	box.interactive = false
