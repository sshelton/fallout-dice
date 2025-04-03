extends PanelContainer

@onready var dice = $VBoxContainer/HBoxContainer/VBoxContainer/LineEdit
@onready var log_container = $VBoxContainer/HBoxContainer/ScrollContainer/Log

@onready var vault_boy = preload("res://vault_boy_w.png")
@onready var boom = preload("res://boom_w.png")
@onready var bang_bang = preload("res://bang_bang_w.png")
@onready var blank = preload("res://blank_die.png")

signal next_scene(scene)

var rng = RandomNumberGenerator.new()
var term_green = Color(.23, .8, .27, 1.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _check_inputs(dice):
	var dic = int(dice)
	if dic < 1:
		return false
	return true


func _process_roll(dice):
	var rolls = []
	var damage = 0
	var effects = 0
	var label = RichTextLabel.new()
	label.fit_content = true
	label.bbcode_enabled = true
	for n in range(dice):
		rolls.append(rng.randi_range(1, 6))
	for roll in rolls:
		if roll >= 5:
			damage += 1
			effects += 1
		elif roll == 2:
			damage += 2
		elif roll == 1:
			damage += 1
	var template = "DAMAGE: %d EFFECTS: %d\n" % [damage, effects]
	template += "ROLLS: "
	for roll in rolls:
		if roll >= 5:
			template += "[img=24]vault_boy.png[/img]"
		elif roll == 3 or roll == 4:
			template += "[img=24]blank_die.png[/img]"
		elif roll == 2:
			template += "[img=24]bang_bang.png[/img]"
		elif roll == 1:
			template += "[img=24]boom.png[/img]"
	label.text = template
	print(template)
	label.modulate = Color(1.5, 1.5, 1.5, 1.0)
	log_container.add_child(label)


func _on_run_button_pressed():
	var result = _check_inputs(int(dice.text))
	if not result:
		var label = Label.new()
		label.text = "ERROR: INVALID PARAMETERS"
		label.modulate = Color(1.5, 1.5, 1.5, 1.0)
		log_container.add_child(label)
	else:
		_process_roll(int(dice.text))
		dice.text = ""


func _on_back_button_pressed():
	emit_signal("next_scene", "res://MainMenu.tscn")



func _on_location_button_pressed():
	var roll = rng.randi_range(1, 20)
	var label = Label.new()
	var location = ""
	match roll:
		1, 2:
			location = "HEAD"
		3, 4, 5, 6, 7, 8:
			location = "TORSO"
		9, 10, 11:
			location = "LEFT ARM"
		12, 13, 14:
			location = "RIGHT ARM"
		15, 16, 17:
			location = "LEFT LEG"
		18, 19, 20:
			location = "RIGHT LEG"

	label.text = "HIT LOCATION: %d %s" % [roll, location]
	label.modulate = Color(1.5, 1.5, 1.5, 1.0)
	log_container.add_child(label)
