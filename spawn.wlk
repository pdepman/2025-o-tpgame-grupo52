import comida.*
import wollok.game.*

object generadorDeIngredientes {
  const todos = [pan, lechuga_cortada, tomate, paty_cocinado, bacon_cocinado, huevo_cocinado]
  var property activos = []


 // Genera el siguiente ingrediente faltante y lo agrega al juego
  method generarSiguiente() {
    var faltantes = todos.filter({ i => not activos.contains(i) })
    if (faltantes.isEmpty().not()) {   // Si todavía quedan ingredientes por aparecer
      var nuevo = faltantes.first()
      if (nuevo != null) {
        activos.add(nuevo)
        game.addVisual(nuevo)
        nuevo.volver()
      }
    }
  }

  method liberar(ingrediente) { // elimina un ingrediente del juego cuando ya no está activo
    if (activos.contains(ingrediente)) {
      activos.remove(ingrediente)
      game.removeVisual(ingrediente)
    }
  }

  method limpiar() {
    activos.forEach({ i => game.removeVisual(i) })
    activos.clear()
  }
}
