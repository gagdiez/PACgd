extends PACInteractive

# The description is set in the Inspector, here we only add what is special
# about the white box: using the red box on it places one box on top of the other.

func _ready():
	id = "white_box"


func use_item(who, box):
	who.approach(self)
	who.say("Time to place one box on top of the other")
	who.animate_until_finished(who.anim_raise_hand)
	who.remove_from_inventory(box)
	self.run(place_box.bind(box))
	who.animate_until_finished(who.anim_lower_hand)
	who.say("That is it, thank you for playing")


func place_box(box):
	box.global_position = self.global_position + Vector3(0, 2, 0)
	box.visible = true

	# Change its main action, so you cannot take it anymore
	box.main_action = PAC.actions.walk_to

	# The boxes are not interactive anymore
	interactive = false
	box.interactive = false
