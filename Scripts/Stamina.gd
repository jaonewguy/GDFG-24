class_name Stamina
extends Node2D

func _ready() -> void:
    SignalBus.connect("update_stamina", self, "_update_stamina")

func _update_stamina(points: int) -> void:
    $Label.text = "x" + str(points)
    
