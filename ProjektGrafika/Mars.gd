extends MeshInstance3D

# Parametry orbity
var orbit_center = Vector3(0, 0, 0) # Położenie Słońca
var orbit_radius = 20000.0 # Promień orbity
var orbit_speed = 0.001 # Prędkość obrotu

var angle: float = 0.0

func _ready():
	orbit_center = get_parent().get_node("Sun").position

func _process(delta):
	rotate_y(delta * 0.01)
	# Aktualizacja kąta
	angle += orbit_speed * delta
	if angle > TAU:
		angle -= TAU
	
	# Obliczanie nowej pozycji na orbicie
	var new_x = (orbit_center.x + 150) + orbit_radius * cos(angle)
	var new_z = (orbit_center.z + 150) + orbit_radius * sin(angle)
	position = Vector3(new_x, orbit_center.y, new_z)
