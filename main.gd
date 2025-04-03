extends PanelContainer

@onready var main_container = $MarginContainer
@onready var audio = $AudioStreamPlayer

var shutting_down = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_change_scene("res://boot.tscn")
	audio.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not shutting_down:
		if audio.get_playback_position() > 20.0:
			audio.seek(14.0)


func _change_scene(scene):
	for child in main_container.get_children():
		child.queue_free()
	if scene == "quit":
		shutting_down = true
		audio.seek(22.0)
	else:
		var new_scene = load(scene).instantiate()
		main_container.add_child(new_scene)
		new_scene.connect("next_scene", _change_scene)


func _on_audio_stream_player_finished():
	get_tree().quit()
