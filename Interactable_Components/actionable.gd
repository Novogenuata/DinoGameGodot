extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func action() -> void:

	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

	var shopkeeper_nodes = get_tree().get_nodes_in_group("ShopKeeperSprite")
	if shopkeeper_nodes.size() > 0:
		shopkeeper_nodes[0].play("Talk")

	var trex_nodes = get_tree().get_nodes_in_group("trexsprite")
	if trex_nodes.size() > 0:
		trex_nodes[0].play("talk")

	await DialogueManager.dialogue_ended


	if shopkeeper_nodes.size() > 0:
		shopkeeper_nodes[0].play("Idle")
	if trex_nodes.size() > 0:
		trex_nodes[0].play("Default")
