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
      /crear_equipo            → Crear equipo
      /agregar_participante    → Agregar participante a un equipo
      /crear_proyecto          → Crear proyecto a un equipo
      /mostrar_equipo          → Mostrar equipo
      /listar_equipos          → Listar equipos
      /chat_equipo             → Chat por equipo
      /canal_general           → Canal general
      /sala_tematica           → Sala temática
      /registrar_mentor        → Registrar mentor
      /asignar_mentor          → Asignar mentor a un equipo
      /salir                   → Salir del sistema
      """)
      loop_comandos()

    "/registrar_participante" -> registrar_participante(); loop_comandos()
    "/crear_equipo" -> crear_equipo(); loop_comandos()
    "/agregar_participante" -> agregar_participante_equipo(); loop_comandos()
    "/crear_proyecto" -> crear_y_asignar_proyecto(); loop_comandos()
    "/mostrar_equipo" -> mostrar_equipo(); loop_comandos()
    "/listar_equipos" -> listar_equipos(); loop_comandos()
    "/chat_equipo" -> chat_equipo(); loop_comandos()
    "/canal_general" -> canal_general(); loop_comandos()
    "/sala_tematica" -> sala_tematica(); loop_comandos()
    "/registrar_mentor" -> registrar_mentor(); loop_comandos()
    "/asignar_mentor" -> asignar_mentor_equipo(); loop_comandos()
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

   # OPCIÓN 3: Agregar participante a equipo
  defp agregar_participante_equipo do
    nombre_equipo = IO.gets("Nombre del equipo: ") |> String.trim()
    id_participante = IO.gets("ID del participante: ") |> String.trim() |> String.to_integer()

    equipo = Sistema.buscar_dato(:equipo, :nombre, nombre_equipo)
    participante = Sistema.buscar_dato(:participante, :id, id_participante)

    cond do
      equipo == nil ->
        IO.puts(" No se encontró el equipo.")
      participante == nil ->
        IO.puts(" No se encontró el participante.")
      true ->
        equipo_actualizado = Sistema.agregar_miembro(equipo, participante.id)
        participante_actualizado = Sistema.asignar_equipo(participante, equipo.nombre)
        Sistema.actualizar_dato(:participante, :nombre, nombre_equipo, participante_actualizado )
        Sistema.actualizar_dato(:equipo, :nombre, nombre_equipo, equipo_actualizado)
        IO.puts(" Participante agregado correctamente.")
    end

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

  # OPCIÓN 5: Mostrar equipo
  defp mostrar_equipo do
    nombre = IO.gets("Nombre del equipo a mostrar: ") |> String.trim()
    equipo = Sistema.buscar_dato(:equipo, :nombre, nombre)

    if equipo == nil do
      IO.puts(" No se encontró el equipo.")
    else
      IO.puts("\n Información del equipo:")
      IO.inspect(equipo)
    end

    menu()
  end

  # OPCIÓN 6: Listar equipos
  defp listar_equipos do
    IO.puts("\n Equipos guardados:")
    equipos = Sistema.listar_datos(:equipo)

    if equipos == [] do
      IO.puts("No hay equipos guardados aún.")
    else
      Enum.each(equipos, fn e ->
        IO.puts(" #{e.nombre} (Tema: #{e.tema})")
      end)
    end

    menu()
  end

  # OPCIÓN 7: Chat por equipo 
    defp chat_equipo do
    nombre = IO.gets("Nombre del equipo: ") |> String.trim()
    Chat.iniciar_chat(nombre)
    menu()
  end

  # OPCIÓN 8: Chat general
    defp canal_general do
    IO.puts("\n1. Ver canal general")
    IO.puts("2. Escribir en canal general")
    opcion = IO.gets("→ Opción: ") |> String.trim()

    case opcion do
      "1" -> Chat.mostrar_canal_general()
      "2" -> Chat.canal_general()
      _ -> IO.puts(" Opción no válida.")
    end

    menu()
  end

  #OPCIÓN 9: Salas tematicas
  defp sala_tematica do
    nombre = IO.gets("Tema de la sala: ") |> String.trim()

    IO.puts("\n1. Ver sala")
    IO.puts("2. Escribir en sala")
    opcion = IO.gets("→ Opción: ") |> String.trim()

    case opcion do
      "1" -> Chat.mostrar_sala_tematica(nombre)
      "2" -> Chat.crear_sala_tematica(nombre)
      _ -> IO.puts(" Opción no válida.")
    end

    menu()
  end

  # OPCIÓN 10: Registrar mentor
  defp registrar_mentor do
    id = IO.gets("ID del mentor: ") |> String.trim() |> String.to_integer()
    nombre = IO.gets("Nombre del mentor: ") |> String.trim()
    especialidad = IO.gets("Especialidad o área: ") |> String.trim()

    mentor = Sistema.crear_mentor(id, nombre, especialidad)
    Sistema.guardar_datos(:mentor, mentor)

    IO.puts(" Mentor registrado correctamente.")
    menu()
  end

  #OPCIÓN  11: Asignar mentor a equipo
  defp asignar_mentor_equipo do
    nombre_equipo = IO.gets("Nombre del equipo: ") |> String.trim()
    id_mentor = IO.gets("ID del mentor: ") |> String.trim() |> String.to_integer()

    equipo = Sistema.buscar_dato(:equipo, :nombre, nombre_equipo)
    mentor = Sistema.buscar_dato(:mentor, :id, id_mentor)

    cond do
      equipo == nil ->
        IO.puts(" No se encontró el equipo.")
      mentor == nil ->
        IO.puts(" No se encontró el mentor.")
      true ->
        equipo_actualizado = Map.put(equipo, :mentor, mentor)
        Sistema.actualizar_dato(:equipo, :nombre, nombre_equipo, equipo_actualizado)
        IO.puts(" Mentor asignado correctamente al equipo #{nombre_equipo}.")
    end

    menu()
  end
end

Main.iniciar()
