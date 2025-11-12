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

# Agregar participante al equipo
equipo_actualizado = Sistema.agregar_miembro(equipo, participante)
Sistema.actualizar_dato(:equipo, :nombre, "Basket", equipo_actualizado)
IO.puts(" Participante agregado correctamente al equipo.")

# Crear y asignar proyecto
proyecto = Sistema.crear_proyecto("Canasta Inteligente", "Detector de encestes automáticos", "IoT")
equipo_final = Sistema.asignar_proyecto(equipo_actualizado, proyecto)
Sistema.actualizar_dato(:equipo, :nombre, "Basket", equipo_final)
IO.puts(" Proyecto asignado correctamente al equipo.")

# Mostrar estado final
final = Sistema.buscar_dato(:equipo, :nombre, "Basket")
IO.puts(" Estado final del equipo:")
IO.inspect(final)