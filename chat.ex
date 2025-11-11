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