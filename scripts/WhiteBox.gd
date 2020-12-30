extends Interactive

func _ready():
	# The main_action is (implicitly) "walk_to"
	# The secondary_action is (implicitly) ACTIONS.examine
	
	# We have to stand a couple of pixels away from it to interact
	interaction_position = self.transform.origin - Vector3(3, 0, 0)
	
	# Description
	description = "The mythical white box!"

func use_item(who, item):
	# The WHITE box will interact with the RED one
	who.approach(self)
	who.say("Time to place one box on top of the other")
	who.animate_until_finished("raise_hand")
	who.remove_from_inventory(item)
	who.call_function_from(self, "place_red_box")
	who.animate_until_finished("lower_hand")
	who.say("That is it, thank you for playing")

func place_red_box():
	# Function called by who.queue_interaction_with(self, "place_red_box")
	var red_box = $"../Red Box"
	red_box.transform.origin = self.transform.origin + Vector3(0, 2, 0)
	red_box.visible = true
	
	# Change its main action, so you cannot "use" it anymore
	red_box.main_action = ACTIONS.walk_to
	
	# The boxes are not interactive anymore
	self.interactive = false
	red_box.interactive = false
