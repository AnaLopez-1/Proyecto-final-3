Code.require_file("sistema.ex")
Code.require_file("chat.ex")

defmodule Main do
  def iniciar do
    IO.puts(" Proyecto Final - Programación III")
    menu()
  end

  defp menu do
  IO.puts("\n Bienvenido al sistema de gestión. Escribe un comando o /help para ver opciones.\n")
     loop_comandos()
end

defp loop_comandos do
  comando = IO.gets("→ ") |> String.trim()

  case comando do
    "/help" ->
      IO.puts("""
      Comandos disponibles:
      
      /registrar_participante  → Registrar participante
      /salir                   → Salir del sistema
      """)
      loop_comandos()

    "/registrar_participante" -> registrar_participante(); loop_comandos()
    "/salir" ->
      
      IO.puts(" Saliendo del sistema...")
      :ok

    "" ->
      loop_comandos()

    _ ->
      IO.puts("  Comando no reconocido. Escribe /help para ver los disponibles.")
      loop_comandos()
  end
end


  
  # OPCIÓN 1: Registrar participante
  defp registrar_participante do
    id = IO.gets("ID: ") |> String.trim() |> String.to_integer()
    nombre = IO.gets("Nombre: ") |> String.trim()
    correo = IO.gets("Correo: ") |> String.trim()
    afinidad = IO.gets("Afinidad o tema: ") |> String.trim()

    participante = Sistema.crear_participante(id, nombre, correo, afinidad)
    Sistema.guardar_datos(:participante, participante)

    IO.puts(" Participante registrado correctamente.")
    menu()
  end