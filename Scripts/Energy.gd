class_name Energy
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func _on_Energy_body_entered(body: Node) -> void:
    SignalBus.emit_signal("energy_pickup")
    queue_free()
