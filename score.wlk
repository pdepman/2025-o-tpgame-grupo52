import temporizador.*
import chef.*
import receta.*
class Marcador{
    const chef 
    var property puntos = 0
    const property position = game.at(1, 1)

    method incrementar(cant) {
        puntos = puntos + cant
    }

    method obtener() = puntos

    method actualizar() {
        self.incrementar(10)
    }

  
    method text() = "Score: " + puntos
    method textColor() = "000000FF"
    method fontSize() = 20
}

const marcador1 = new Marcador(position = game.at(1, 0),chef = jugador1)

const marcador2 = new Marcador(position = game.at(21, 0),chef = jugador2)

class Pedido {
  var property receta
  var property position 

  method image() = receta.nombre() + "_pedido.png"
  
}
object sistemaPedidos {

   var property pedidosActivos = []

  const posicionesPedidos = [
    game.at(5, 13),
    game.at(9, 13),
    game.at(13, 13),
    game.at(17, 13)
  ]

  const property maxPedidos = 4

// method iniciar() {
//     game.schedule(20000, { self.generarPedido() })
//   }

  method generarPedido() {
    
    const posicionLibre = self.obtenerPosicionLibre()

    if (pedidosActivos.size() < maxPedidos) {
        const pedido = new Pedido(receta=sistemaDeRecetas.recetaRandom(),position = posicionLibre)
    pedidosActivos.add(pedido)
    game.addVisual(pedido)
        
    }

 
  }


  method completarPedido(receta) {
    const pedido = pedidosActivos.find({ p => p.receta() == receta })
    if (pedido != null) {
      pedidosActivos.remove(pedido)
      game.removeVisual(pedido)
    }
  }
  
  method obtenerPosicionLibre() =
    posicionesPedidos.find({ pos =>
      not pedidosActivos.any({ p => p.position() == pos })
    })

    
  method estaElPedido(receta) = pedidosActivos.any({ p => p.receta() == receta })

  method eliminarPedido(receta) {
    const pedido = pedidosActivos.find({ p => p.receta() == receta })
    if (pedido != null) {
      pedidosActivos.remove(pedido)
      game.removeVisual(pedido)
    }
  }
}