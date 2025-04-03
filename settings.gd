extends PanelContainer

@onready var vol_down = $VBoxContainer/HBoxContainer/VolDown
@onready var vol_up = $VBoxContainer/HBoxContainer/VolUp
@onready var vol_label = $VBoxContainer/HBoxContainer/Volume

@onready var volume_levels = {
	0: "100%", 
	-6: "90%", 
	-12: "80%", 
	-18: "70%", 
	-24: "60%",
	-30: "50%",
	-36: "40%",
	-42: "30%",
	-48: "20%",
	-54: "10%",
	-60: "0%",
}

signal next_scene(scene)

var vol_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	vol_level = AudioServer.get_bus_volume_db(0)
	print(vol_level)
	print(volume_levels)
	vol_label.text = volume_levels[int(vol_level)]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_vol_down_pressed():
	if vol_level > -60:
		vol_level -= 6
		AudioServer.set_bus_volume_db(0, vol_level)
		vol_label.text = volume_levels[int(vol_level)]


func _on_vol_up_pressed():
	if vol_level < 0:
		vol_level += 6
		AudioServer.set_bus_volume_db(0, vol_level)
		vol_label.text = volume_levels[int(vol_level)]


func _on_back_button_pressed():
	emit_signal("next_scene", "res://MainMenu.tscn")
