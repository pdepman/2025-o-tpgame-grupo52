import temporizador.*
import chef.*
import receta.*
import menu.*
class Marcador{
    var property puntos = 0
    const property position = game.at(1, 1)
    const modo 

  method iniciar() {
    game.addVisual(self)
  }

  method quitar() {
    game.removeVisual(self)
  }

    method incrementar(cant) {
        puntos = puntos + cant
    }

    method obtener() = puntos

    method actualizar() {
        self.incrementar(10)
    }
  method reiniciar(){
     puntos = 0
  }
  method modoCopPuntos()=listaContadores.sum({contador=>contador.puntos()})
  
    method text() = if(modo == coop){"Score: " + self.modoCopPuntos()}else "Score: " + puntos
    method textColor() = "000000FF"
    method fontSize() = 20
}

const listaContadores= [marcador1,marcador2]

const marcador1 = new Marcador(position = game.at(1, 0),modo=versus)

const marcador2 = new Marcador(position = game.at(21, 0),modo=versus)

const marcador = new Marcador(position = game.at(21, 0),modo=coop)

class Pedido {
  var property receta
  var property position 

  method image() = receta.nombre() + "_pedido.png"
  
  method borrar(){
    game.removeVisual(self)
  }

  
}
object sistemaPedidos {

   var property pedidosActivos = []

  const posicionesPedidos = [
    game.at(5, 13),
    game.at(9, 13),
    game.at(13, 13),
    game.at(17, 13)
  ]
  
 


  method reiniciar() {
    pedidosActivos.forEach({pedido=> pedido.borrar()})
    pedidosActivos.clear()
  }

  const property maxPedidos = 4

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