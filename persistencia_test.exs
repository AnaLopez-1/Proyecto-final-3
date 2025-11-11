Code.compile_file("persistencia.ex") # Asegúrate de tener tu módulo Persistencia en este archivo

tipo = "test_datos"
File.rm("#{tipo}.csv")

IO.puts(" Test: guardar y leer ")
Persistencia.guardar(tipo, %{id: 1, nombre: "Jimmy", activo: true})
resultado = Persistencia.leer_todos(tipo)
IO.inspect(resultado)

IO.puts(" Test: buscar")
Persistencia.guardar(tipo, %{id: 2, nombre: "Ana"})
encontrado = Persistencia.buscar(tipo, :nombre, "Ana")
IO.inspect(encontrado)

IO.puts(" Test: actualizar ")
Persistencia.actualizar(tipo, :id, 1, %{id: 1, nombre: "Maritza", activo: false})
actualizado = Persistencia.buscar(tipo, :id, 1)
IO.inspect(actualizado)

IO.puts(" Test: eliminar ")
Persistencia.eliminar(tipo, :id, 2)
restantes = Persistencia.leer_todos(tipo)
IO.inspect(restantes)
