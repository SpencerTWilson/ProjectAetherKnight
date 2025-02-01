extends Button

@export var option: String

func _pressed() -> void:
	OptionsManager.options[option] = $"../TextEdit".text
	OptionsManager._options_updated()
