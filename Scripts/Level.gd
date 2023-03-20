extends Node


# Declare member variables here. Examples:
var picked_up_wood: int = 0
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    SignalBus.connect("wood_pickup", self, "_on_wood_pickup")

func _on_wood_pickup() -> void:
    picked_up_wood += 1
