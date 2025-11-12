Code.require_file("sistema.ex")

# Crear participante y equipo
p = Sistema.crear_participante(101, "Carlos Pérez", "carlos@mail.com", "Deportes")
e = Sistema.crear_equipo("Basket", "Deportes")

Sistema.guardar_datos(:participante, p)
Sistema.guardar_datos(:equipo, e)
IO.puts(" Participante y equipo creados y guardados.")

# Buscar los datos guardados
equipo = Sistema.buscar_dato(:equipo, :nombre, "Basket")
participante = Sistema.buscar_dato(:participante, :id, 101)
