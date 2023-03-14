extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

enum {
    IDLE,
    WANDER,
    CHASE
}

var velocity = Vector2.ZERO
var state = IDLE

onready var sprite = $AnimatedSprite
onready var playerDetectionZone = $PlayerDetectionZone
onready var wanderController = $WanderController

func _ready():
    state = pick_random_state([IDLE, WANDER])
    
func _physics_process(delta: float) -> void:
    print("State:", state)
    match state:
        IDLE:
            velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
            seek_player()
            if wanderController.get_time_left() == 0:
                update_wander()
                
        WANDER:
            seek_player()
            if wanderController.get_time_left() == 0:
                update_wander()
            accelerate_towards_point(wanderController.target_position, delta)
            if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
                update_wander()
        CHASE:
            var player = playerDetectionZone.player
            if player != null:
                accelerate_towards_point(player.global_position, delta)
            else:
                state = IDLE
                
    velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
    var direction = global_position.direction_to(point)
    print("Direction:", direction)
    velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
    sprite.flip_h = velocity.x < 0

func pick_random_state(state_list):
    state_list.shuffle()
    return state_list.pop_front()

func seek_player():
    if playerDetectionZone.can_see_player():
        state = CHASE
        
func update_wander():
    print("Entered update_wander")
    state = pick_random_state([IDLE, WANDER])
    wanderController.start_wander_timer(rand_range(1, 3))
