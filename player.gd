extends Area2D

signal hit

@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size =  get_viewport_rect().size# Replace with function body.
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var valocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		valocity.y += 1
	if Input.is_action_pressed("move_up"):
		valocity.y -= 1
	if Input.is_action_pressed("move_left"):
		valocity.x -= 1
	if Input.is_action_pressed("move_right"):
		valocity.x += 1
	if valocity.length()>0 :
		valocity = valocity.normalized() * 400
		$AnimatedSprite2D.play()
	else :
		$AnimatedSprite2D.stop()
	position += valocity * delta
	position.clamp(Vector2.ZERO,screen_size)
	if valocity.x != 0 :
		$AnimatedSprite2D.animation="walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = valocity.x < 0 
	if valocity.y != 0 :
		$AnimatedSprite2D.animation="up"
		$AnimatedSprite2D.flip_v = valocity.y < 0 

func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit() # Replace with function body.
	$CollisionShape2D.set_deferred("disabled",true)
	

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
