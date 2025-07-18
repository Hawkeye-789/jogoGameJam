extends Node

var file_path = "user://saveData.save"

var save_data = {
	"life":100,
	"itens":{"chave_principal": false, "chave_do_quarto_daniel": false, "medalhao_gay": false},
	"volume":50,
	"sound_effect":50,
	"window":{"borderless": false, "fullscreen": false, "windowed": true},
}

func save_game():
	
	var file_save = FileAccess.open(file_path, FileAccess.WRITE)
	file_save.store_var(save_data)
	file_save.close()

func load_game():
	
	if FileAccess.file_exists(file_path):
		var fileLoad = FileAccess.open(file_path, FileAccess.READ)
		save_data = fileLoad.get_var()
		return save_data
	else:
		print("File Not Found")
		return save_data

func save_all_parameters(data:Dictionary):
	
	save_data = data
	save_game()

func save_only_life(life:int):
	
	if save_data.has("life"):
		save_data.life = life
		save_game()
	else:
		print("Life not found")

func reset_data():
	
	var data_default = {
		"life":100,
		"itens":{"chave_principal": false, "chave_do_quarto_daniel": false, "medalhao_gay": false},
		"volume":50,
		"sound_effect":50,
		"window":{"borderless": false, "fullscreen": false, "windowed": true},
	}
	
	save_data = data_default.duplicate(true)
	save_game()
	return save_data
