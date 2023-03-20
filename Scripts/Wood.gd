class_name Wood
extends Area2D


var wood_picked_up = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func _on_Wood_body_entered(body: Node) -> void:
    SignalBus.emit_signal("wood_pickup")
    queue_free()
