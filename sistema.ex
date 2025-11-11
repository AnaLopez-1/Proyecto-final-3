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






