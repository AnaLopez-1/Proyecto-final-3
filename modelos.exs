defmodule Modelos do

  defmodule Participante do

    defstruct [:id, :nombre, :correo, :equipo, :afinidad]

    def crear(id, nombre, correo, afinidad \\ "No se devuleve nada") do
      %Modelos.Participante{
        id: id,
        nombre: nombre,
        correo: correo,
        afinidad: afinidad,
        equipo: nil
      }
    end
  end


  defmodule Equipo do
  defstruct [:nombre, :tema, :miembros, :proyecto]

  def crear(nombre, tema) do
    %Modelos.Equipo{
      nombre: nombre,
      tema: tema,
      miembros: [],
      proyecto: nil
    }
  end
end


  defmodule Proyecto do
    defstruct [:id, :nombre, :descripcion, :categoria, :estado, :retroalimentacion]

    def crear(id, nombre, descripcion, categoria) do
      %Modelos.Proyecto{
        id: id,
        nombre: nombre,
        descripcion: descripcion,
        categoria: categoria,
        estado: "en_progreso",
        retroalimentacion: []
      }
    end
  end

  defmodule Mentor do
    defstruct [:id, :nombre, :especialidad]

    def crear(id, nombre, especialidad) do
      %Modelos.Mentor{
        id: id,
        nombre: nombre,
        especialidad: especialidad
      }
    end


  end
end
