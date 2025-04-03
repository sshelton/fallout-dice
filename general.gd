extends PanelContainer

@onready var log_container = $VBoxContainer/HBoxContainer/ScrollContainer/Log
@onready var dice_label = $VBoxContainer/HBoxContainer/VBoxContainer/Dice
@onready var sides_label = $VBoxContainer/HBoxContainer/VBoxContainer/Sides

signal next_scene(scene)

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_run_button_pressed():
	var result = _check_inputs(dice_label.text, sides_label.text)
	if not result:
		var label = Label.new()
		label.text = "ERROR: INVALID PARAMETERS"
		label.modulate = Color(1.5, 1.5, 1.5, 1.0)
		log_container.add_child(label)
	else:
		_process_roll(int(dice_label.text), int(sides_label.text))
		dice_label.text = ""
		sides_label.text = ""

func _on_back_button_pressed():
	emit_signal("next_scene", "res://MainMenu.tscn")


func _check_inputs(dice, sides):
	var dic = int(dice)
	var sid = int(sides)
	if dic < 1 or sid < 2:
		return false
	return true

func _process_roll(dice, sides):
	var rolls = []
	var sum = 0
	for n in range(dice):
		rolls.append(randi_range(1, sides))
		sum += rolls[-1]
	var label = Label.new()
	label.text = "ROLLS: " + " ".join(rolls)
	label.text += "\nTOTAL: %d" % sum
	label.modulate = Color(1.5, 1.5, 1.5, 1.0)
	log_container.add_child(label)
	
