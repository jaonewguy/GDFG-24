class_name Bat extends KinematicBody2D

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

onready var bat_sprite = $Sprites/EnemySprite
onready var player_detection_zone = $PlayerDetectionZone
onready var wander_controller = $WanderController

func _ready():
    state = pick_random_state([IDLE, WANDER])
    
func _physics_process(delta: float) -> void:
#    print("State:", state)
    match state:
        IDLE:
            velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
            seek_player()
            if wander_controller.get_time_left() == 0:
                update_wander()
                
        WANDER:
            seek_player()
            if wander_controller.get_time_left() == 0:
                update_wander()
            accelerate_towards_point(wander_controller.target_position, delta)
            if global_position.distance_to(wander_controller.target_position) <= WANDER_TARGET_RANGE:
                update_wander()
        CHASE:
            var player = player_detection_zone.player
            if player != null:
                accelerate_towards_point(player.global_position, delta)
            else:
                state = IDLE
                
    velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
    var direction = global_position.direction_to(point)
#    print("Direction:", direction)
    velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
    bat_sprite.flip_h = velocity.x < 0

func pick_random_state(state_list):
    state_list.shuffle()
    return state_list.pop_front()

func seek_player():
    if player_detection_zone.can_see_player():
        state = CHASE
        
func update_wander():
#    print("Entered update_wander")
    state = pick_random_state([IDLE, WANDER])
    wander_controller.start_wander_timer(rand_range(1, 3))


func _on_Bat_Hurtbox_area_entered(area):
    queue_free()
