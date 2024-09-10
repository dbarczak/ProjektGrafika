extends MeshInstance3D


# Funkcja uruchamiająca się przy starcie
func _ready():
	# Ustawienie, aby funkcja _process była wywoływana co klatkę
	set_process(true)

# Funkcja wywoływana co klatkę
func _process(delta):
	# Obrót obiektu wokół własnej osi Y z prędkością delta * 0.1
	rotate_y(delta * 0.1)
