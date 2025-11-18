Code.require_file("chat.ex")

# Chat de equipo
Chat.iniciar_chat("Basket")
IO.puts(" Chat de equipo creado y probado (chat_Basket.txt).")

# Canal general
Chat.canal_general()
IO.puts(" Canal general probado (chat_general.txt).")

# Sala temática
Chat.crear_sala_tematica("Educacion")
IO.puts(" Sala temática creada y probada (chat_sala_Educacion.txt).")

IO.puts(" Archivos generados:")
Enum.each(File.ls!("."), fn file ->
  if String.starts_with?(file, "chat_") do
    IO.puts("• #{file}")
  end
end)
