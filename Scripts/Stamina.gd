class_name Stamina
extends Node2D

func _ready() -> void:
    SignalBus.connect("spend_stamina", self, "update_stamina")
    SignalBus.connect("increase_stamina", self, "_on_stamina_increase")

func update_stamina(points: int) -> void:
    $Label.text = "x" + str(points)
    
func _on_stamina_increase(stamina: int) -> void:
    update_stamina(stamina)
