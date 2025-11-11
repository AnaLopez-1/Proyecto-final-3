defmodule Sistema do
  Code.require_file("modelos.ex")
  Code.require_file("persistencia.ex")

  # Crear entidades
  def crear_participante(id, nombre, correo, afinidad) do
    Modelos.Participante.crear(id, nombre, correo, afinidad)
  end

  def crear_equipo(nombre, tema) do
    Modelos.Equipo.crear(nombre, tema)
  end

  def crear_mentor(id, nombre, especialidad) do
    Modelos.Mentor.crear(id, nombre, especialidad)
  end

  def crear_proyecto(nombre, descripcion, categoria) do
    Modelos.Proyecto.crear(nombre, descripcion, categoria)
  end

  # Guardar en archivos globales
  def guardar_datos(tipo, dato) do
    Persistencia.guardar(tipo, dato)
  end

  def listar_datos(tipo) do
    Persistencia.leer_todos(tipo)
  end

  def buscar_dato(tipo, campo, valor) do
    Persistencia.buscar(tipo, campo, valor)
  end

  def actualizar_dato(tipo, campo, valor, nuevo_dato) do
    Persistencia.actualizar(tipo, campo, valor, nuevo_dato)
  end

  # Lógica de negocio
  def agregar_miembro(equipo, participante) do
  miembros_actuales =
    case equipo.miembros do
      lista when is_list(lista) -> lista
      "" -> []          # si viene vacío del CSV
      nil -> []         # por si el campo no existe
      otro -> [otro]    # si viene un solo nombre como string
    end

  miembros_actualizados = miembros_actuales ++ [participante]
  %{equipo | miembros: miembros_actualizados}
end

def listar_id_participantes do
    IO.puts("\n Participantes guardados:")
    participantes = Sistema.listar_datos(:participante)

    if participantes == [] do
      IO.puts("No hay participantes guardados aún.")
    else

      Enum.each(participantes, fn participante->
        IO.puts(" #{participante.id}}")
      end)
    end
  end

def listar_nombre_equipos do
    IO.puts("\n Equipos guardados:")
    equipos = Sistema.listar_datos(:equipo)

    if equipos == [] do
      IO.puts("No hay equipos guardados aún.")
    else

      Enum.each(equipos, fn equipo->
        IO.puts(" #{equipo.nombre}}")
      end)
    end
  end


def asignar_equipo(participante, equipo) do
  nombre_equipo =
    case equipo do
      %{nombre: nombre} -> nombre          # si es struct o mapa con campo :nombre
      nombre when is_binary(nombre) -> nombre  # si ya es un string
      _ -> equipo                # por si llega otro tipo
    end
  %{participante | equipo: nombre_equipo}
  end

   def listar_id_proyectos do
    IO.puts("\n proyectos guardados:")
    proyectos = Sistema.listar_datos(:proyecto)

    if proyectos == [] do
      IO.puts("No hay proyectos guardados aún.")
    else

      Enum.each(proyectos, fn proyecto->
        IO.puts(" #{proyecto.id}}")
      end)
    end
  end

  def asignar_proyecto(equipo, proyecto) do
  id_proyecto =
    case proyecto do
      %{id: id} -> id          # si es struct o mapa con campo :id
      id when is_integer(id) -> id  # si ya es un número
      _ -> proyecto                # por si llega otro tipo
    end

  %{equipo | proyecto: id_proyecto}
end
end






