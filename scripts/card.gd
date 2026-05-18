class_name Card extends Node2D

@export var card_name: String = "Card Name"
@export var card_description: String = "Card Description"
@export var card_cost: int = 1
@export var card_img: Node2D

@onready var cost_lb: Label = $CostDisplay/CostLb
@onready var name_lb: Label = $CardName/NameLb
@onready var description_lb: Label = $CardDescription


func _ready() -> void:
	cost_lb.set_text(str(card_cost))
	name_lb.set_text(card_name)
	description_lb.set_text(card_description)

func _process(delta: float) -> void:
	pass
