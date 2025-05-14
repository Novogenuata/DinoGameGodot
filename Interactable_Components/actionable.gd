extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func action() -> void:
	if Dialogueclickmanager.is_dialogue_active:
		return
	Dialogueclickmanager.is_dialogue_active = true

	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	var shopkeepers = get_tree().get_nodes_in_group("ShopKeeperSprite")
	if shopkeepers.size() > 0:
		shopkeepers[0].play("Talk")
	var trexes = get_tree().get_nodes_in_group("trexsprite")
	if trexes.size() > 0:
		trexes[0].play("talk")
	await DialogueManager.dialogue_ended
	if shopkeepers.size() > 0:
		shopkeepers[0].play("Idle")
	if trexes.size() > 0:
		trexes[0].play("Default")
	Dialogueclickmanager.is_dialogue_active = false
