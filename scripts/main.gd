extends Control

var life = 100
var itens = {"chave_principal": false, "chave_do_quarto_daniel": false, "medalhao_gay": false}
var volume = 50
var sound_effect = 50
var window = {"borderless": false, "fullscreen": false, "windowed": true}

@onready var lbLife = $%Lb_life
@onready var lbItens = $%Lb_itens
@onready var lbVolume = $%Lb_volume
@onready var lbSound_effect = $%Lb_sound_effect
@onready var lbWindow = $%Lb_window

func _ready():
	var result = SaveSystem.load_game()
	print(result)
	update_parameters(result) 
	
#================================================================
#                     events buttons
#================================================================

func _on_bt_reset_save_pressed():
	
	var result = SaveSystem.reset_data()
	update_parameters(result)
	
func _on_bt_load_pressed():
	
	var result = SaveSystem.load_game()
	update_parameters(result)
	
func _on_bt_save_all_pressed():
	
	SaveSystem.save_all_parameters({
		"life":life, 
		"itens":itens,
		"volume": volume,
		"sound_effect": sound_effect,
		"window": window,
	})

func _on_bt_save_life_pressed():
	
	SaveSystem.save_only_life(life)
	
func _on_bt_add_life_pressed():
	if life + 10 <= 100:
		life += 10
		update_label_life()

func _on_bt_sub_life_pressed():
	if life - 10 >= 0:
		life -= 10
		update_label_life()
	
func _on_bt_add_chave_principal_pressed():
	itens["chave_principal"] = true
	update_label_itens()
	
func _on_bt_sub_chave_principal_pressed():
	itens["chave_principal"] = false
	update_label_itens()
	
func _on_bt_up_volume_pressed():
	if volume + 10 <= 100:
		volume += 10
		update_label_volume()

func _on_bt_down_volume_pressed():
	if volume - 10 >= 0:
		volume -= 10
		update_label_volume()
		
func _on_bt_up_sound_effect_pressed():
	if sound_effect + 10 <= 100:
		sound_effect += 10
		update_label_sound_effect()
		
func _on_bt_down_sound_effect_pressed():
	if sound_effect - 10 >= 0:
		sound_effect -= 10
		update_label_sound_effect()
		
func _on_bt_windowed_pressed():
	window["windowed"] = true
	window["borderless"] = false
	window["fullscreen"] = false
	update_label_window()
	
func _on_bt_borderless_pressed():
	window["borderless"] = true
	window["windowed"] = false
	window["fullscreen"] = false
	update_label_window()
	
func _on_bt_fullscreen_pressed():
	window["fullscreen"] = true
	window["windowed"] = false
	window["borderless"] = false
	update_label_window()

#====================================================================
#                   functions 
#====================================================================
	
func update_label_life():
	
	lbLife.text = str("Vida: ",life)
	
func update_label_itens():
	
	lbItens.text = str("Itens: ",itens)
	
func update_label_volume():
	
	lbVolume.text = str("Volume: ",volume)
	
func update_label_sound_effect():
	
	lbSound_effect.text = str("Sound Effect: ",sound_effect)
	
func update_label_window():
	
	lbWindow.text = str("Window: ",window)

func update_parameters(data):
	
	life = data.life
	itens = data.itens
	volume = data.volume
	sound_effect = data.sound_effect
	window = data.window
	update_label_life()
	update_label_itens()
	update_label_volume()
	update_label_sound_effect()
	update_label_window()
