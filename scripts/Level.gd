extends Spatial

# This is the main script for the Level.

func _ready():
	# For the players, we need to define their "navigation" and "camera"
	# properties.
	# -The Navigation NODE will guide our character through the level, telling
	#  him which paths to follow to go from one place to the other
	# -The Camera lets the player know which direction he should be facing when
	#  moving around 
	$Cole.navigation = $Navigation
	$Cole.camera = $Camera
	
	# We need to initialize our point and click system letting it know:
	# - Who's the player
	$PointClick.init($Cole)
