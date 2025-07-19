extends Control

@export var music_container : VBoxContainer
@export var sfx_container : VBoxContainer

@export var music_bar : TextureProgressBar
@export var sfx_bar : TextureProgressBar

var volume_music : float
var volume_sfx : float

@export var buttons_for_neighbor : Array[Button]

func give_focus(neighbor : Control) -> void:
	buttons_for_neighbor[0].grab_focus()
	for button in buttons_for_neighbor:
		button.focus_neighbor_left = neighbor.get_path()

func _change_bar_value(bar : TextureProgressBar, added_value : float) -> void:
	bar.value += added_value

func _connect_signal(container : VBoxContainer, button_name: String, bar : TextureProgressBar, value: float) -> void:
	var button = container.find_child(button_name, true)
	button.pressed.connect(_change_bar_value.bind(bar, value))

func _connect_buttons(container : VBoxContainer) -> void:
	var bar : TextureProgressBar = container.find_child("VolumeSlider", true)
	_connect_signal(container, "MinusButton", bar, -0.05)
	_connect_signal(container, "PlusButton", bar, 0.05)
	_connect_signal(container, "FullVolumeButton", bar, 1)
	_connect_signal(container, "MuteButton", bar, -1)

func get_volumes(music_volume : float, sfx_volume : float) -> void:
	volume_music = music_volume
	volume_sfx = sfx_volume
	
	_initialize()

func _initialize() -> void:
	_connect_buttons(music_container)
	_connect_buttons(sfx_container)
	
	music_bar.value = volume_music
	sfx_bar.value = volume_sfx

func _on_music_bar_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))

func _on_sfx_bar_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
