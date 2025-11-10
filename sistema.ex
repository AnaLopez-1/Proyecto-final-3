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