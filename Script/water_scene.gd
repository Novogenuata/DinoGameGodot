extends Node2D


func _on_exitgate_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#change to the water scene with the water gun
		SceneManager.change_scene("res://MainScenes/MainGame.tscn")
		
