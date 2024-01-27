extends CharacterBody3D


@export var speed = 5.0
@export var jump_speed = 4.5
@export var mouse_sensitivity = 0.002
@export var bullet_scene: PackedScene
@export var bullet_speed= 10.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("click"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			get_viewport().set_input_as_handled()
	if event.is_action_pressed("shoot"):
		shoot()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()

func shoot() :
	var bullet = bullet_scene.instantiate()
	# We store the reference to the SpawnLocation node.
	var bullet_spawn_location = $Camera3D/GunBillboard/BulletSpawn
	bullet.global_position = bullet_spawn_location.global_position
	var aim = $Camera3D.get_global_transform().basis
	var forward = -aim.z
	
	# check ray cast point
	
	#var space_state = get_world_3d().direct_space_state
	#var cam = $Camera3D
	#var mousepos = get_viewport().get_mouse_position()
	#var origin = cam.project_ray_origin(mousepos)
	#var end = origin + cam.project_ray_normal(mousepos) * 1000
	#var query = PhysicsRayQueryParameters3D.create(cam.global_position, end)
	#query.collide_with_areas = true

	#var result = space_state.intersect_ray(query)

	var bullet_dir = forward
	#if result :
	#	bullet_dir = result.position - bullet.global_position
	#	bullet_dir = bullet_dir.normalized()
	
	bullet.linear_velocity = bullet_dir * bullet_speed
	get_tree().current_scene.add_child(bullet)
