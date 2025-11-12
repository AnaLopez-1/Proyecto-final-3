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

  
  # OPCIÓN 2: Crear equipo
  defp crear_equipo do
    nombre = IO.gets("Nombre del equipo: ") |> String.trim()
    tema = IO.gets("Tema del equipo: ") |> String.trim()

    equipo = Sistema.crear_equipo(nombre, tema)
    Sistema.guardar_datos(:equipo, equipo)

    IO.puts(" Equipo creado correctamente.")
    menu()
  end





  # OPCIÓN 4: Crear proyecto y asignarlo
  defp crear_y_asignar_proyecto do
    nombre_equipo = IO.gets("Nombre del equipo: ") |> String.trim()
    equipo = Sistema.buscar_dato(:equipo, :nombre, nombre_equipo)

    if equipo == nil do
      IO.puts(" No se encontró el equipo.")
    else
      nombre_proy = IO.gets("Nombre del proyecto: ") |> String.trim()
      desc = IO.gets("Descripción: ") |> String.trim()
      categoria = IO.gets("Categoría: ") |> String.trim()

      proyecto = Sistema.crear_proyecto(nombre_proy, desc, categoria)
      equipo_act = Sistema.asignar_proyecto(equipo, proyecto)
      Sistema.actualizar_dato(:equipo, :nombre, nombre_equipo, equipo_act)

      IO.puts(" Proyecto creado y asignado correctamente.")
    end

    menu()
  end