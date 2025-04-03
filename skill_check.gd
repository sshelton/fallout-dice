extends PanelContainer

@onready var log_container = $VBoxContainer/HBoxContainer/ScrollContainer/Log
@onready var target = $VBoxContainer/HBoxContainer/VBoxContainer/Target
@onready var difficulty = $VBoxContainer/HBoxContainer/VBoxContainer/Difficulty
@onready var dice = $VBoxContainer/HBoxContainer/VBoxContainer/Dice
@onready var complication = $VBoxContainer/HBoxContainer/VBoxContainer/Complication

signal next_scene(scene)

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	emit_signal("next_scene", "res://MainMenu.tscn")


func _on_run_button_pressed():
	var result = _check_inputs(
		target.text, 
		difficulty.text, 
		dice.text, 
		complication.text
	)
	if not result:
		var label = Label.new()
		label.text = "ERROR: INVALID PARAMETERS"
		label.modulate = Color(1.5, 1.5, 1.5, 1.0)
		log_container.add_child(label)
	else:
		_process_roll(
			int(target.text), 
			int(difficulty.text), 
			int(dice.text), 
			int(complication.text)
		)
		target.text = ""
		difficulty.text = ""
		dice.text = ""
		complication.text = ""


func _check_inputs(target, difficulty, dice, complication):
	var tar = int(target)
	var dif = int(difficulty)
	var dic = int(dice)
	var com = int(complication)
	if tar < 1 or dif < 1 or dic < 1 or com < 0:
		return false
	return true


func _process_roll(target, difficulty, dice, complication):
	var rolls = []
	var success = 0
	var complications = 0
	var label = Label.new()
	
	if complication == 0:
		complication = 20
	for n in range(dice):
		rolls.append(rng.randi_range(1, 20))
	for roll in rolls:
		if roll <= target:
			success += 1
		elif roll >= complication:
			complications += 1
	var template = "TARGET: %d \t DIFFICULTY: %d\n" % [target, difficulty]
	template += "COMPLICATION RANGE: %d\n" % [complication]
	template += "===========================\n"
	template += "SUCCESS: %d \t COMPLICATIONS: %d\n\n" % [success, complications]
	if success >= difficulty:
		template += "CHECK PASS!\n"
	template += "ROLLS: " + " ".join(rolls)
	label.text = template
	label.modulate = Color(1.5, 1.5, 1.5, 1.0)
	log_container.add_child(label)

