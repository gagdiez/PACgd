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

func take(who):
	who.approach(self)
	who.animate_until_finished("raise_hand")
	who.call_function_from(self, "grab")
	who.add_to_inventory(self)
	who.animate_until_finished("lower_hand")

func grab():
	visible = false
	interactive = false
