extends Node2D


func _ready() -> void:
    pass


func _on_Timer_timeout() -> void:
    SignalBus.emit_signal("game_over")
