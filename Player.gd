extends KinematicBody2D

var SPEED = 80
var ATTACKS = ["Attack1", "Attack2"]

var state_machine
var velocity = Vector2.ZERO

func _ready() -> void:
    state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta: float) -> void:
    get_input()
    velocity = move_and_slide(velocity)

func get_input() -> void:
#    var current = state_machine.get_current_node()
    velocity = Vector2.ZERO
    if Input.is_action_just_pressed("attack"):
        state_machine.travel(ATTACKS[randi() % 2])
        return
    if Input.is_action_pressed("right"):
        velocity.x += 1
        $Sprite.scale.x = 1
    if Input.is_action_pressed("left"):
        velocity.x -= 1
        $Sprite.scale.x = -1
    if Input.is_action_pressed("up"):
        velocity.y -= 1
    if Input.is_action_pressed("down"):
        velocity.y += 1
        
    velocity = velocity.normalized() * SPEED
    
    if velocity.length() != 0:
        state_machine.travel("Run")
    if velocity.length() == 0:
        state_machine.travel("Idle")
    
#func hurt():
#    state_machine.travel("hurt")
#
#func die():
#    state_machine.travel("die")
#    set_physics_process(false)
