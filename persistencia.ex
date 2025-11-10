defmodule Persistencia do
  @moduledoc """
  Maneja guardado, carga y actualización de datos en archivos CSV.
  Compatible con estructuras que contengan listas o mapas.
  """

  #Función para guardar archivos CSV
  def guardar(tipo, mapa) do
    archivo = obtener_archivo(tipo)
    mapa = Map.drop(mapa, [:__struct__])
    encabezado = Map.keys(mapa)
    fila = Map.values(mapa) |> Enum.map(&to_string/1)

    if not File.exists?(archivo) do
      contenido = [Enum.join(encabezado, ","), Enum.join(fila, ",")]
      File.write!(archivo, Enum.join(contenido, "\n"))
    else
      File.write!(archivo, "\n" <> Enum.join(fila, ","), [:append])
    end
  end

  