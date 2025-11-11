Code.require_file("sistema.ex")
Code.require_file("chat.ex")

defmodule Main do
  def iniciar do
    IO.puts(" Proyecto Final - Programación III")
    menu()
  end

  defp menu do
  IO.puts("\n Bienvenido al sistema de gestión. Escribe un comando o /help para ver opciones.\n")

end