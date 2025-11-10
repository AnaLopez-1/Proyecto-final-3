defmodule Sistema do
  Code.require_file("modelos.ex")
  Code.require_file("persistencia.ex")

  # Crear entidades
  def crear_participante(id, nombre, correo, afinidad) do
    Modelos.Participante.crear(id, nombre, correo, afinidad)
  end
