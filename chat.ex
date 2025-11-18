defmodule Chat do

  #Inicializar chat general
  def canal_general do
    iniciar_chat("general")
  end

  def mostrar_canal_general do
    mostrar_chat("general")
  end

  #Inicializqar chat equipo 
  def iniciar_chat(nombre_equipo) do
    nombre_archivo = "chat_#{nombre_equipo}.txt"

    unless File.exists?(nombre_archivo) do
      File.write(nombre_archivo, "")
      IO.puts(" Nuevo chat creado para #{nombre_equipo}.")
    end

    IO.puts(" Entrando al chat de #{nombre_equipo}...")
    bucle_chat(nombre_equipo)
  end

    defp bucle_chat(nombre_equipo) do
    mensaje = IO.gets("\nEscribe un mensaje (o 'salir' / 'ver' / 'vivo'): ") |> String.trim()

    cond do
      mensaje == "salir" ->
        IO.puts(" Saliendo del chat de #{nombre_equipo}...")

      mensaje == "ver" ->
        mostrar_chat(nombre_equipo)
        bucle_chat(nombre_equipo)

      mensaje == "vivo" ->
        chat_en_vivo(nombre_equipo)

      mensaje != "" ->
        timestamp = NaiveDateTime.local_now() |> NaiveDateTime.to_time() |> to_string()
        File.write("chat_#{nombre_equipo}.txt", "[#{timestamp}] #{mensaje}\n", [:append])
        IO.puts(" Mensaje guardado.")
        bucle_chat(nombre_equipo)

      true ->
        bucle_chat(nombre_equipo)
    end
  end

  #Función ver chat existente 
  def mostrar_chat(nombre_equipo) do
    case File.read("chat_#{nombre_equipo}.txt") do
      {:ok, contenido} when contenido != "" ->
        IO.puts("\n Chat de #{nombre_equipo}:\n")
        IO.puts(contenido)

      {:ok, _} ->
        IO.puts(" No hay mensajes en este chat.")

      {:error, _} ->
        IO.puts(" No existe chat para #{nombre_equipo}.")
    end
  end

  # CHAT EN VIVO (simula tiempo real)

  def chat_en_vivo(nombre_equipo) do
    IO.puts("\n chat en vivo para #{nombre_equipo}")

    loop = fn loop_fun, anterior ->
      case File.read("chat_#{nombre_equipo}.txt") do
        {:ok, contenido} ->
          if contenido != anterior do
            IO.puts("\n--- Actualización ---")
            IO.puts(contenido)
          end
          :timer.sleep(3000)
          loop_fun.(loop_fun, contenido)

        _ ->
          IO.puts(" No existe chat #{nombre_equipo}.")
      end
    end

    loop.(loop, "")
  end


  # SALAS TEMÁTICAS

  def crear_sala_tematica(nombre_tema) do
    iniciar_chat("sala_#{nombre_tema}")
  end

  def mostrar_sala_tematica(nombre_tema) do
    mostrar_chat("sala_#{nombre_tema}")
  end
end


