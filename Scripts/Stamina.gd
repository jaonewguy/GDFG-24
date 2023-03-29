class_name Stamina
extends Node2D

func _ready() -> void:
    SignalBus.connect("spend_stamina", self, "update_stamina")

func update_stamina(points: int) -> void:
    $Label.text = "x" + str(points)
