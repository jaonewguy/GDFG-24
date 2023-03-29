extends KinematicBody2D

const SPEED = 80
var ATTACKS = ["Attack1", "Attack2"]

var state_machine
var velocity = Vector2.ZERO
var stamina: int

func _ready() -> void:
    state_machine = $AnimationTree.get("parameters/playback")
    SignalBus.connect("energy_pickup", self, "_on_energy_pickup")

func _physics_process(delta: float) -> void:
    get_input()
    velocity = move_and_slide(velocity)

func get_input() -> void:
#    var current = state_machine.get_current_node()
    velocity = Vector2.ZERO
    if Input.is_action_just_pressed("attack") and stamina > 0:
        state_machine.travel(ATTACKS[randi() % 2])
        stamina -= 1
        SignalBus.emit_signal("update_stamina", stamina)
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

func set_stamina(player_stamina: int):
    stamina = player_stamina
    SignalBus.emit_signal("update_stamina", stamina)

func _on_Area2D_body_entered(body: Node) -> void:
    if body is Bat:
        body.get_node("Sprites/OnlyDarkSprite").hide()
        body.get_node("Sprites/EnemySprite").show()

func _on_Area2D_body_exited(body: Node) -> void:
    if body is Bat:
        body.get_node("Sprites/OnlyDarkSprite").show()
        body.get_node("Sprites/EnemySprite").hide()

func _on_energy_pickup() -> void:
    stamina += 1
    SignalBus.emit_signal("update_stamina", stamina)
#    print("Energy picked up! Stamina at: ", stamina)
