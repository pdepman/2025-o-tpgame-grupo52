import hitbox.*
import wollok.game.*
import comida.*
import elementosDeCocina.*
import spawn.*

class Chef {
  var cambio = ""
  var sostiene = null
  var orientacion = derecha
  var position = game.origin()
  var sufijo = "Default"
  
  method position() = position
  
  method orientacion() = orientacion
  
  method position(nuevaPosition) {
    position = nuevaPosition
  }
  
  method direccionObjeto() =  orientacion.desplazamiento()

  method inventarioVacio() = sostiene == null
  
  method image() = (("chef" + sufijo) + cambio) + ".png"
  
  method mover(dx, dy) {
    var nueva = game.at(position.x() + dx, position.y() + dy)
    if ((not pared.todopuedeMoverA(
        nueva.x(),
        nueva.y()
      )) and (not self.hayColisionEn(nueva))) self.position(nueva)
  }
  
  method moverComida(ingrediente) {
    if (!self.inventarioVacio()) {
      var posChefActual = self.position()
      var direccion

      direccion = self.direccionObjeto()

      ingrediente.position(
        posChefActual.x() + direccion.x(),
        posChefActual.y() + direccion.y() 
      )
    }
  }
  
  method hayColisionEn(destino) = destino == jugador2.position()
  
  method configurarTeclas() {
  keyboard.a().onPressDo({ self.intentarMover(izquierda) })
  keyboard.d().onPressDo({ self.intentarMover(derecha) })
  keyboard.w().onPressDo({ self.intentarMover(arriba) })
  keyboard.s().onPressDo({ self.intentarMover(abajo) })
  keyboard.e().onPressDo({ self.tomarComida() })
  keyboard.q().onPressDo({generadorDeIngredientes.generarSiguiente()
  })
}

  
  method intentarMover(direccion) {
    if (orientacion == direccion) {
      if (direccion.puedeMover(self)) direccion.mover(self)
    }
    sufijo = direccion.sufijo()
    orientacion = direccion
    self.moverComida(sostiene)
  }
  
  method ingredienteCercano() {
    var posicionAdelante = self.position()
    
    if (orientacion == derecha) posicionAdelante = posicionAdelante.right(1)
    if (orientacion == izquierda) posicionAdelante = posicionAdelante.left(1)
    if (orientacion == arriba) posicionAdelante = posicionAdelante.up(1)
    if (orientacion == abajo) posicionAdelante = posicionAdelante.down(1)
    
    return objetosmobibles.find({ i => i.position() == posicionAdelante })
  }
  
  method llevar(ingrediente) {
    sostiene = ingrediente
  }
  
  method quitar(ingrediente) {
    if (sostiene == ingrediente) {
      sostiene = null
    }
  }
  
  method tomarComida() {
    if (self.inventarioVacio()) {
      const ingredienteCercano = self.ingredienteCercano()
      if (ingredienteCercano != null) {
        ingredienteCercano.estaEnInventario(true)
        self.llevar(ingredienteCercano)
        cambio = "_agarro"
      }
    } else {
      const ingrediente = sostiene
      self.moverComida(ingrediente)
      self.quitar(ingrediente)
      cambio = ""
      
      const platoDestino = platos.find(
        { p => p.position() == ingrediente.position() }
      )
      
      if ((platoDestino != null) and (ingrediente != platoDestino)) {
        platoDestino.agregarIngrediente(ingrediente)
        game.removeVisual(ingrediente)
        ingrediente.volver()
        game.addVisual(ingrediente)
      }
      platos.forEach(
        { p =>
          if (p.position() == cajon.position()) p.intentarAceptar()
          if (p.position() == tacho.position()) p.eliminarComida()
        }
      )
    }
  }
}

class Chef2 inherits Chef {
  override method configurarTeclas() {
  keyboard.left().onPressDo({ self.intentarMover(izquierda) })
  keyboard.right().onPressDo({ self.intentarMover(derecha) })
  keyboard.up().onPressDo({ self.intentarMover(arriba) })
  keyboard.down().onPressDo({ self.intentarMover(abajo) })
  keyboard.enter().onPressDo({ self.tomarComida() })
  keyboard.shift().onPressDo({generadorDeIngredientes.generarSiguiente()
  })
}

  
  override method hayColisionEn(destino) = destino == jugador1.position()
}

const jugador1 = new Chef(position = game.at(12, 3))
const jugador2 = new Chef2(position = game.at(20, 3))

object izquierda {
  const position = game.at(-1,0)

  method puedeMover(personaje) = topeIzq.position().x() < personaje.position().x()
  method mover(personaje) = personaje.mover(-1, 0)
  method sufijo() = "Izquierda"
  method desplazamiento() = position  
}

object derecha {
  const position = game.at(1,0)
  method puedeMover(personaje) = topeDer.position().x() > personaje.position().x()
  method mover(personaje) = personaje.mover(1, 0)
  method sufijo() = "Derecha"
  method desplazamiento() = position  
}

object arriba {
  const position = game.at(0,1)
  method puedeMover(personaje) = topeArriba.position().y() > personaje.position().y()
  method mover(personaje) = personaje.mover(0, 1)
  method sufijo() = "Espaldas"
  method desplazamiento() = position  
}

object abajo {
  const position = game.at(0,-1)
  method puedeMover(personaje) = topeAbajo.position().y() < personaje.position().y()
  method mover(personaje) = personaje.mover(0, -1)
  method sufijo() = "Default"
  method desplazamiento() = position  
}

const objetosmobibles = [
  pan,
  lechuga_cortada,
  tomate,
  paty_cocinado,
  bacon_cocinado,
  huevo_cocinado
] + platos

const platos = [plato1, plato2]

