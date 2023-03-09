extends KinematicBody2D

var speed = 200
var velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
    get_input()
    velocity = move_and_slide(velocity)

func get_input() -> void:
    velocity = Vector2.ZERO
    if Input.is_action_pressed('right'):
        velocity.x += 1
    if Input.is_action_pressed('left'):
        velocity.x -= 1
    if Input.is_action_pressed('down'):
        velocity.y += 1
    if Input.is_action_pressed('up'):
        velocity.y -= 1
    # Make sure diagonal movement isn't faster
    velocity = velocity.normalized() * speed
    
