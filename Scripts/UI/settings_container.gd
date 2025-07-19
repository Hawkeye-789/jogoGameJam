extends MarginContainer

@export var audio_button : Button
@export var video_button : Button
@export var audio_menu : Control
@export var video_menu : Control

func give_focus(neighbor : Control) -> void:
	audio_button.focus_neighbor_left = neighbor.get_path()
	video_button.focus_neighbor_left = neighbor.get_path()
	_on_audio_button_pressed()

func _on_audio_button_pressed() -> void:
	audio_menu.visible = true
	video_menu.visible = false
	audio_menu.give_focus(audio_button)


func _on_video_button_pressed() -> void:
	video_menu.visible = true
	audio_menu.visible = false
	video_menu.give_focus(video_button)
