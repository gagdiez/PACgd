extends Interactive

func _ready():
	# The green box starts being invisible, and we cannot interact with it
	visible = false
	interactive = false
	
	# We can take it
	main_action = ACTIONS.take
	
	# We have to stand a couple of pixels away from it to interact
	position = self.transform.origin + Vector3(3, 0, 0)
	
	# Description and thumbnail
	description = "That's a new box"
	thumbnail = "res://thumbnails/green_box.png"

func take(who):
	# When we click on the box, this function will be executed
	# We get Cole close, make him "grab" the box, and add it to his inventory
	who.approach(self)
	who.face_object(self)
	who.animate_until_finished("raise_hand")
	who.interact(self, "grab")
	who.add_to_inventory(self)
	who.animate_until_finished("lower_hand")

func grab():
	# Function called by line 24: who.interact(self, "grab")
	visible = false
	interactive = false
