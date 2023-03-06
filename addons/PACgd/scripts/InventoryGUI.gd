extends Panel

const ITEM_SIZE = Vector2(48, 48)
@onready var SLOT_SIZE = $Slots.get_theme_constant('h_separation') + ITEM_SIZE.x

var inventory_to_follow

func follow(inventory:Inventory):
	if inventory_to_follow:
		inventory_to_follow.disconnect("item_added",Callable(self,"item_added"))
		inventory_to_follow.disconnect("item_removed",Callable(self,"item_removed"))
	
	inventory_to_follow = inventory
	inventory_to_follow.connect("item_added",Callable(self,"item_added"))
	inventory_to_follow.connect("item_removed",Callable(self,"item_removed"))
	
	for item in inventory.items:
		item_added(item)

func position_contained(position: Vector2):
	var top = position.y > $Slots.offset_top
	var bottom = position.y < $Slots.offset_bottom - $Slots.offset_top
	return top and bottom

func get_object_in_position(position: Vector2):
	var item_idx = int(floor(position.x / SLOT_SIZE))
	var modulus = fmod(position.x, SLOT_SIZE)

	if modulus > $Slots.offset_left and item_idx < inventory_to_follow.size():
		return inventory_to_follow.get(item_idx)
	else:
		return null

func item_added(item):
	var texturerect = TextureRect.new()
	texturerect.texture = load(item.thumbnail)
	texturerect.size = ITEM_SIZE
	$Slots.add_child(texturerect)

func item_removed(item):
	for child in $Slots.get_children():
		$Slots.remove_child(child)
	follow(inventory_to_follow)
