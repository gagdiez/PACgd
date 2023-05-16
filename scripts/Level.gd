extends Node3D

# This is the main script for the Level.

func _ready():
	# For the players, we need to define their "camera"

	# - The Camera3D lets the player know which direction he should be facing when
	#   moving around 
	$Cole.camera = $Camera
	
	# We need to initialize our point and click system letting it know:
	# - Who's the player
	$PointClick.init($Cole)
