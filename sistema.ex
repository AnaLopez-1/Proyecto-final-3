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
  