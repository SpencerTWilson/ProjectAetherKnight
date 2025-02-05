extends Component

var magic_dir = 0
var on = false
@export var directions = {
	"CENTER": Vector2.ZERO,
	"UP": Vector2.UP,
	"DOWN": Vector2.DOWN,
	"LEFT": Vector2.LEFT,
	"RIGHT": Vector2.RIGHT
}

@export var color_rect : ColorRect
@export var glitch : Node
@export var intensity = 2.5

@export var UI : Control
@export var up : TextureRect
@export var left : TextureRect
@export var right : TextureRect
@export var down : TextureRect
@export var center : TextureRect

@export var up_higlight : TextureRect
@export var left_higlight : TextureRect
@export var right_higlight : TextureRect
@export var down_higlight : TextureRect
@export var center_higlight : TextureRect

@export var camera_state_machine : Node
var prev_state

signal magic_player

func activate():
	#called when a component is activated
	pass

func deactivate():
	#called when a component is deactivated
	pass


func active(delta):
	if Input.is_action_just_pressed("Magic"):
		on = true
		Engine.time_scale = 0.1
		UI.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		prev_state = camera_state_machine.current_state.name
		camera_state_machine.transition("freeze_camera")
		glitch.visible = true
	
	if Input.is_action_just_released("Magic"):
		on = false
		Engine.time_scale = 1.0
		UI.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		magic_player.emit(magic_dir)
		camera_state_machine.transition(prev_state)
		glitch.visible = false
	
	if on:
		color_rect.material.set_shader_parameter("intensity", lerp(color_rect.material.get_shader_parameter("intensity"), intensity, 50.0 * delta))
		center_higlight.visible = false
		left_higlight.visible = false
		right_higlight.visible = false
		up_higlight.visible = false
		down_higlight.visible = false
		
		
		var mpos = get_viewport().get_mouse_position() - (get_viewport().size / 2.)
		var normalized_mpos : Vector2 = mpos.normalized()
		
		var closest_dist : float = normalized_mpos.distance_to(directions.values()[0])
		var closest_dir : Vector2 = directions.values()[0]
		for dir in directions.values():
			if normalized_mpos.distance_to(dir) < closest_dist:
				closest_dist = normalized_mpos.distance_to(dir)
				closest_dir = dir
		
		magic_dir = directions.find_key(closest_dir).to_lower()
		
		if directions["CENTER"] != null && mpos.distance_to(Vector2.ZERO) < 100:
			magic_dir = "center"
		
		
		match magic_dir:
			"center":
				center_higlight.visible = true
			"left":
				left_higlight.visible = true
			"right":
				right_higlight.visible = true
			"up":
				up_higlight.visible = true
			"down":
				down_higlight.visible = true
	else:
		
		color_rect.material.set_shader_parameter("intensity", lerp(color_rect.material.get_shader_parameter("intensity"), 15., 1.0 * delta))
		

func active_physics(delta):
	pass
