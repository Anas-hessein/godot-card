extends Node2D

const COLLISION_MASK_CARD = 1

var screen_size
var card_being_dragged

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(_delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		# Use global_position so it follows the mouse correctly regardless of parents
		card_being_dragged.global_position = Vector2(
			clamp(mouse_pos.x, 0, screen_size.x), 
			clamp(mouse_pos.y, 0, screen_size.y)
		)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var card = raycast_check_for_card()
			if card:
				card_being_dragged = card
				print("Grabbed: ", card.name) # Debug print
		else:
			card_being_dragged = null
	
func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	
	# FIX: Use global mouse position here
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD
	
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		# FIX: Access dictionary via string key
		return result[0]["collider"]
	return null
