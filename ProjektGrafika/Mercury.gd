extends MeshInstance3D
# Parametry orbity
var orbit_center = Vector3(0, 0, 0) # Położenie Słońca
var orbit_radius = 7500.0 # Promień orbity
var orbit_speed = 0.01 # Prędkość obrotu planety wokół Słońca
# Kąt, który będzie aktualizowany dla ruchu po orbicie
var angle: float = 0.0

func _ready():
	# Ustawienie centrum orbity na pozycję Słońca
	orbit_center = get_parent().get_node("Sun").position

func _process(delta):
	# Rotacja planety wokół własnej osi (obrót planety)
	rotate_y(delta * 0.01)
	
	# Aktualizacja kąta
	angle += orbit_speed * delta
	if angle > TAU:
		angle -= TAU # Reset kąta po pełnym obrocie
	
	# Obliczanie nowej pozycji na orbicie
	var new_x = orbit_center.x + orbit_radius * cos(angle)
	var new_z = orbit_center.z + orbit_radius * sin(angle)
	# Aktualizacja pozycji planety na orbicie
	position = Vector3(new_x, orbit_center.y, new_z)
