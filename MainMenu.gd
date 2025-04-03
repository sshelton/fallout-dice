extends PanelContainer

signal next_scene(scene)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_skill_check_pressed():
	emit_signal("next_scene", "res://skill_check.tscn")


func _on_damage_pressed():
	emit_signal("next_scene", "res://damage.tscn")


func _on_generic_pressed():
	emit_signal("next_scene", "res://general.tscn")


func _on_shutdown_pressed():
	emit_signal("next_scene", "quit")


func _on_settings_pressed():
	emit_signal("next_scene", "res://settings.tscn")
