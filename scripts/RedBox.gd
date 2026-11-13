extends PACInteractive

func _ready():
	id = "red_box"

	# We can take this object
	main_action = PAC.actions.take

	# The secondary_action is (implicitly) PAC.actions.examine
	# Where to stand to interact: the InteractionPoint marker in the scene

	# Description and Thumbnail
	description = "The box I have to move"
	thumbnail = preload("res://thumbnails/red_box.png")


func take(who):
	who.approach(self)
	who.animate_until_finished(who.anim_raise_hand)
	self.run(grab)
	who.add_to_inventory(self)
	who.animate_until_finished(who.anim_lower_hand)


func grab():
	self.visible = false
	interactive = false
