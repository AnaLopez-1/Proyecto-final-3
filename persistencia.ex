defmodule Persistencia do
  @moduledoc """
  Maneja guardado, carga y actualización de datos en archivos CSV.
  Compatible con estructuras que contengan listas o mapas.
  """

  #Función para guardar archivos CSV
  def guardar(:participante, mapa) do
    archivo = obtener_archivo(:participante)
    mapa = Map.drop(mapa, [:__struct__])

    orden = [:id, :nombre, :correo, :afinidad, :equipo]
    encabezado = Enum.join(orden, ",")
    fila = orden |> Enum.map(&to_string(mapa[&1])) |> Enum.join(",")

    if not File.exists?(archivo) do
      File.write!(archivo, encabezado <> "\n" <> fila)
    else
      File.write!(archivo, "\n" <> fila, [:append])
    end
  end

  def guardar(:equipo, mapa) do
    archivo = obtener_archivo(:equipo)
    mapa = Map.drop(mapa, [:__struct__])

    orden = [:nombre, :tema, :proyecto, :miembros, :mentor]
    encabezado = Enum.join(orden, ",")

    fila =
      orden
      |> Enum.map(fn clave ->
        valor = mapa[clave]

        cond do
          is_list(valor) -> Enum.join(valor, ";")
          is_map(valor) -> valor.id
          true -> to_string(valor)
        end
      end)
      |> Enum.join(",")

    if not File.exists?(archivo) do
      File.write!(archivo, encabezado <> "\n" <> fila)
    else
      File.write!(archivo, "\n" <> fila, [:append])
    end
  end

  def guardar(:proyecto, mapa) do
    archivo = obtener_archivo(:proyecto)
    mapa = Map.drop(mapa, [:__struct__])

    orden = [:id, :nombre, :descripcion, :categoria, :estado, :retroalimentacion, :equipo]
    encabezado = Enum.join(orden, ",")

    fila =
      orden
      |> Enum.map(fn clave ->
        valor = mapa[clave]

        cond do
          is_list(valor) -> Enum.join(valor, ";")
          true -> to_string(valor)
        end
      end)
      |> Enum.join(",")

    if not File.exists?(archivo) do
      File.write!(archivo, encabezado <> "\n" <> fila)
    else
      File.write!(archivo, "\n" <> fila, [:append])
    end
  end

  def guardar(:mentor, mapa) do
  archivo = obtener_archivo(:mentor)
  mapa = Map.drop(mapa, [:__struct__])

  # Define el orden de los campos que quieres guardar
  orden = [:id, :nombre, :especialidad]
  encabezado = Enum.join(orden, ",")
  fila = orden |> Enum.map(&to_string(mapa[&1])) |> Enum.join(",")

  if not File.exists?(archivo) do
    File.write!(archivo, encabezado <> "\n" <> fila)
  else
    File.write!(archivo, "\n" <> fila, [:append])
  end
end

  #Función para leer archivos CSV
  def leer_todos(tipo) do
  archivo = obtener_archivo(tipo)

  if File.exists?(archivo) do
    [cabecera | filas] =
      File.read!(archivo)
      |> String.split("\n", trim: true)

    claves =
      String.split(cabecera, ",")
      |> Enum.map(&String.trim/1)
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&String.to_atom/1)

    filas
    |> Enum.map(fn fila ->
      fila = String.trim(fila)

      if fila == "" do
        nil
      else
        valores = String.split(fila, ",") |> Enum.map(&convertir_tipo/1)
        Enum.zip(claves, valores) |> Enum.into(%{})
      end
    end)
    |> Enum.reject(&is_nil/1)
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

  #Función convertir tipo (Al leer)
  defp convertir_tipo(""), do: nil

defp convertir_tipo(valor) do
  cond do
    valor =~ ~r/^\d+$/ ->
      String.to_integer(valor)

    String.contains?(valor, ";") ->
      valor
      |> String.split(";")
      |> Enum.map(fn v ->
        try do
          String.to_integer(v)
        rescue
          _ -> v
        end
      end)

    true ->
      valor
  end
end

    defp obtener_archivo(tipo), do: "#{tipo}.csv"
end
