extends PanelContainer

@onready var label = $Label
@onready var transition = $OutTimer
var typing = false

signal next_scene(scene)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if typing:
		label.visible_ratio += randf_range(.04, .24) * delta
		if label.visible_ratio >= 1:
			transition.start()
			typing = false


func _on_out_timer_timeout():
	next_scene.emit("res://MainMenu.tscn")


func _on_start_timer_timeout():
	typing = true
