extends MeshInstance3D

# Prędkość normalna
var speed = 30000.0
# Prędkość z nitro (boost)
var boost_speed = 530000.0
# Prędkość rotacji statku
var rotation_speed = 1.0
# Zmienna logiczna do sprawdzania, czy statek się porusza
var is_moving = false

func _ready():
	# Funkcja wywoływana przy uruchomieniu, ustawia procesowanie każdej klatki
	set_process(true)

func _process(delta):
	# Wektor kierunku ruchu
	var direction = Vector3()
	is_moving = false
	
	# Sprawdzenie, czy nitro jest aktywne
	# Jeśli przycisk "boost" jest wciśnięty, prędkość zwiększa się do boost_speed
	var current_speed = speed
	if Input.is_action_pressed("boost"):
		current_speed = boost_speed
	
	# Ruch przód-tył
	# Jeśli przycisk "move_forward" jest wciśnięty, statek porusza się do przodu
	if Input.is_action_pressed("move_forward"):
		direction += global_transform.basis.z * current_speed * delta
		is_moving = true
	# Jeśli przycisk "move_backward" jest wciśnięty, statek porusza się do tyłu
	if Input.is_action_pressed("move_backward"):
		direction -= global_transform.basis.z * current_speed * delta
		is_moving = true

	# Aktualizacja pozycji
	# Jeśli statek się porusza, translacja w kierunku obliczonym w wektorze 'direction'
	if is_moving:
		global_translate(direction)

	# Obrót wokół osi Y (lewo-prawo)
	# Jeśli statek się porusza, sprawdzane są kierunki ruchu poziomego
	if is_moving:
		if Input.is_action_pressed("move_left"):
			rotate_object_local(Vector3.UP, rotation_speed * delta)
		if Input.is_action_pressed("move_right"):
			rotate_object_local(Vector3.UP, -rotation_speed * delta)
		
		# Obrót wokół osi X (góra-dół)
		# Obrót w górę i w dół, aby kontrolować wznoszenie i opadanie statku
		if Input.is_action_pressed("move_down"):
			rotate_object_local(Vector3.RIGHT, rotation_speed * delta)
		if Input.is_action_pressed("move_up"):
			rotate_object_local(Vector3.RIGHT, -rotation_speed * delta)
