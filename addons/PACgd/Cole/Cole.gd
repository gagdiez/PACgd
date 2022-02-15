extends Character

func _ready():
	SPEED = 5
	MINIMUM_WALKABLE_DISTANCE = 0.5
	talk_bubble_offset = Vector3(0, 9.7, 0)
	
	main_action = ACTIONS.none
	secondary_action = ACTIONS.none
