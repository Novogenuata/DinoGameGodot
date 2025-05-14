extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"







func action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
		
	var trexnodes = get_tree().get_nodes_in_group("Trexsprite")
	if trexnodes.size() > 0:
		var anim_sprite = trexnodes[0]
		anim_sprite.play("Talking")
		await DialogueManager.dialogue_ended
		anim_sprite.play("Default")
	
		
		
