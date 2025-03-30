extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"






func action() -> void:

	
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	var shopkeeper_nodes = get_tree().get_nodes_in_group("ShopKeeperSprite")
	if shopkeeper_nodes.size() > 0:
		var anim_sprite = shopkeeper_nodes[0]
		anim_sprite.play("Talk")
		await DialogueManager.dialogue_ended
		anim_sprite.play("Idle")
