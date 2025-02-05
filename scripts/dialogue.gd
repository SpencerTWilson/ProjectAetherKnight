extends Control
class_name DialogueTextBox

@export_category("Parser")
@export var dialogue_parser : DialogueParser
@export var default_ID : String
@export var data : DialogueData

@export_category("References")
@export var textbox : RichTextLabel
@export_subgroup("options-slide")
@export var options : Control
@export var slider : Control

@export_subgroup("options-text")
@export var texbox_option1 : RichTextLabel
@export var Panel_option1 : Panel
@export var texbox_option2 : RichTextLabel
@export var Panel_option2 : Panel

@export_subgroup("Typewriter")
@export var typewriter_timer : Timer

@export_subgroup("Auto-Answer")
@export var auto_timer : Timer
@export var progress_bar : TextureProgressBar


var ready_for_input = false
var waiting_for_input = false
var display = 0
var current_command = ""

signal camera_signal(value : int)
signal play_animation(value : String)
signal special_signal(value : String)

func _process(delta):
	if !current_command.begins_with("Auto"):
		if ready_for_input:
			if Input.is_action_just_pressed("dialogue_option1"):
				dialogue_parser.select_option(0)
			if Input.is_action_just_pressed("dialogue_option2"):
				dialogue_parser.select_option(1)
		if waiting_for_input:
			if Input.is_anything_pressed():
				dialogue_parser.select_option(1)
				waiting_for_input = false
	
	match display:
		0:
			position.x = lerp(position.x, -(size.x + 200), 3 * delta)
			slider.position.x = lerp(slider.position.x, -(slider.size.x - 20), 6 * delta)
			slider.modulate.a = lerp(slider.modulate.a, 0.0, 6 * delta)
		1:
			position.x = lerp(position.x, 0.0, 3 * delta)
			slider.position.x = lerp(slider.position.x, -(slider.size.x - 20), 6 * delta)
			slider.modulate.a = lerp(slider.modulate.a, 0.0, 6 * delta)
		2:
			position.x = lerp(position.x, 0.0, 3 * delta)
			slider.position.x = lerp(slider.position.x, slider.size.x * 0.08, 3 * delta)
			slider.modulate.a = lerp(slider.modulate.a, 1.0, 6 * delta)
	
	if !auto_timer.is_stopped():
		progress_bar.value = 100 - ((auto_timer.time_left / auto_timer.wait_time) * 100)
	else:
		progress_bar.value = 0

func _enter_tree():
	dialogue_parser.data = data
	dialogue_parser.dialogue_processed.connect(_on_dialogue_processed)
	dialogue_parser.dialogue_signal.connect(_on_dialogue_signal)

func start(ID : String = default_ID):
	
	if not dialogue_parser.is_running():
		dialogue_parser.start(ID)

func select_option(idx : int):
	dialogue_parser.select_option(idx)

func _on_dialogue_processed(speaker : Variant, dialogue : String, options : Array[String]):
	textbox.visible_characters = 0
	typewriter_timer.start()
	textbox.text = dialogue
	display = 1
	
	current_command = ""
	
	if options.size() > 0:
		texbox_option1.text = options[0]
		if options.size() > 1:
			texbox_option2.text = options[1]
			if options.size() > 2:
				current_command = options[2]
		else:
			texbox_option2.text = ""
	else:
		texbox_option1.text = ""
	
	Panel_option2.visible = true
	Panel_option1.visible = true
	if texbox_option1.text.lstrip(" ") == "":
		Panel_option1.visible = false
	if texbox_option2.text.lstrip(" ") == "":
		Panel_option2.visible = false

func _on_dialogue_signal(value : String):
	if value.begins_with("Camera"):
		emit_signal("camera_signal",value.split(":")[1])
	elif value.begins_with("Animation"):
		emit_signal("play_animation",value.split(":")[1])
	elif value.begins_with("End"):
		end()
		pass
	else:
		emit_signal("special_signal",value)

func _on_auto_timer_timeout():
	current_command = ""
	dialogue_parser.select_option(2)

func _on_timer_typewriter_timeout():
	if textbox.text.length() >= textbox.visible_characters:
		textbox.visible_characters += 1
	else:
		print(current_command)
		if current_command.begins_with("Auto"):
			auto_timer.wait_time = float(current_command.split(":")[1])
			if auto_timer.is_stopped():
				auto_timer.start()
		elif current_command.begins_with("Wait"):
			display = 1
			waiting_for_input = true
			
		else:
			ready_for_input = true
			display = 2
		typewriter_timer.stop()

func end():
	if !current_command.begins_with("Auto"):
		typewriter_timer.stop()
		display = 0
		dialogue_parser.stop()
