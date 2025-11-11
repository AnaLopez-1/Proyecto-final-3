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

  #Función para leer archivos CSV
    def leer_todos(tipo) do
    archivo = obtener_archivo(tipo)

    if File.exists?(archivo) do
      [cabecera | filas] =
        File.read!(archivo)
        |> String.split("\n", trim: true)

      claves = String.split(cabecera, ",") |> Enum.map(&String.to_atom/1)

      Enum.map(filas, fn fila ->
        valores =
          String.split(fila, ",")
          |> Enum.map(&convertir_tipo/1)

        Enum.zip(claves, valores) |> Enum.into(%{})
      end)
    else
      []
    end
  end

  #Función para buscar archivos CSV
  def buscar(tipo, campo, valor) do
    leer_todos(tipo)
    |> Enum.find(&(&1[campo] == valor))
  end

  #Función para actualizar archivos CSV
  def actualizar(tipo, campo, valor, nuevo_dato) do
    lista =
      leer_todos(tipo)
      |> Enum.map(fn x ->
        if x[campo] == valor, do: Map.drop(nuevo_dato, [:__struct__]), else: x
      end)

    escribir_todos(tipo, lista)
  end

  #Función para eliminar archivos CSV
  def eliminar(tipo, campo, valor) do
    nueva = Enum.reject(leer_todos(tipo), &(&1[campo] == valor))
    escribir_todos(tipo, nueva)
  end

  #Función para escribir todo de manera Interna
  defp escribir_todos(tipo, lista) do
    archivo = obtener_archivo(tipo)

    if lista == [] do
      File.rm(archivo)
    else
      claves = Map.keys(hd(lista))

      lineas =
        [Enum.join(claves, ",")]
        ++ Enum.map(lista, fn m ->
          Enum.map(claves, fn clave ->
            valor = m[clave]

            cond do
              is_list(valor) ->
                Enum.map(valor, &inspect/1) |> Enum.join(";")
              is_map(valor) ->
                inspect(valor)
              true ->
                to_string(valor)
            end
          end)
          |> Enum.join(",")
        end)

      File.write!(archivo, Enum.join(lineas, "\n"))
    end
  end

  #Convierte el tipo a leer
  defp convertir_tipo(valor) do
    cond do
      valor =~ ~r/^\d+$/ -> String.to_integer(valor)
      valor == "true" -> true
      valor == "false" -> false
      String.contains?(valor, ";") -> String.split(valor, ";")
      true -> valor
    end
  end


  # ARCHIVO SEGÚN TIPO
  defp obtener_archivo(tipo), do: "#{tipo}.csv"
end
