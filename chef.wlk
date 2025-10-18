import hitbox.*
import wollok.game.*
import comida.*
import elementosDeCocina.*

class Chef {
  var cambio = "3"
  var sostiene = []
  var orientacion = 1
  var position = game.origin()
  const property DERECHA = 1
  const property ABAJO = 2
  const property ARRIBA = 3
  const property IZQUIERDA = 4
  var sufijo = "Default"
  
  method position() = position
  
  method orientacion() = orientacion
  
  method position(nuevaPosition) {
    position = nuevaPosition
  }
  
  method image() = ("chef" + sufijo) + ".png"
  
  
  method mover(direccion) {
    var nueva = direccion.proximaPosicion(position)
    if ((not pared.todopuedeMoverA(
        nueva.x(),
        nueva.y()
      )) and (not self.hayColisionEn(nueva))) self.position(nueva)
       self.image()
      self.moverComida()
      //Cuando se agarra un objeto, este "acompaña" al chef donde este mira (adelante de el)
  }
  
  method inventarioVacio() = sostiene.isEmpty()
  
  method moverComida() {
    if (!self.inventarioVacio()) {
      //Si tenemos un objeto agarrado
      var posChefActual = self.position()
      var sentidoX = 0
      var sentidoY = 0
      if (self.orientacion() == 1) {
        sentidoX = 1
      }
      if (self.orientacion() == 2) {
        sentidoY = -1
      }
      if (self.orientacion() == 3) {
        sentidoY = 1
      }
      if (self.orientacion() == 4) {
        sentidoX = -1
      }
      pan.position(posChefActual.x() + sentidoX, posChefActual.y() + sentidoY)
    }
  }
  
  method hayColisionEn(destino) = destino == jugador2.position()
  
  method configurarTeclas() {
    keyboard.a().onPressDo({ self.intentarMover(izquierda) })
    keyboard.d().onPressDo({ self.intentarMover(derecha) })
    keyboard.w().onPressDo({ self.intentarMover(arriba) })
    keyboard.s().onPressDo({ self.intentarMover(abajo) })
    keyboard.e().onPressDo({ self.tomarComida() })
  }
  
  method intentarMover(direccion) {
    if (direccion.puedeMover(self)) {
      direccion.mover(self)
      orientacion = direccion.orientacionConstante(self)
      sufijo = direccion.sufijo()
    }
  }
  
  method tienePan() = sostiene.any({ c => c == pan })
  
  method tomarComida() {
    if (self.inventarioVacio()) {
      //Si no tiene nada
      if (self.hayPan()) {
        pan.estaEnInventario(true)
        //Actualizamos la comida para decir que está en el inventario 
        self.llevar(pan)
        cambio = "4"
      }
    } else {
      self.moverComida()
      self.quitar(pan)
      cambio = "3"
    }
  }
  
  method celdasAdyacente() = [
    self.position().left(1),
    self.position().right(1),
    self.position().up(1),
    self.position().down(1)
  ]
  
  method hayPan() = self.celdasAdyacente().any({ c => c == pan.position() })
  
  method llevar(comida) {
    sostiene.add(comida)
  }
  
  method quitar(comida) {
    sostiene.remove(comida)
  }
}

class Chef2 inherits Chef {
  override method configurarTeclas() {
    keyboard.left().onPressDo({ self.intentarMover(izquierda) })
    keyboard.right().onPressDo({ self.intentarMover(derecha) })
    keyboard.up().onPressDo({ self.intentarMover(arriba) })
    keyboard.down().onPressDo({ self.intentarMover(abajo) })
    keyboard.enter().onPressDo({ self.tomarComida() })
  }
  
  override method hayColisionEn(destino) = destino == jugador1.position()
}

const jugador1 = new Chef(position = game.at(12, 3))

const jugador2 = new Chef2(position = game.at(20, 3))

object izquierda {
  method puedeMover(
    personaje
  ) = (topeIzq.position().x() + 8) < personaje.position().x()
  
  method mover(personaje) = personaje.mover(-1, 0)
  
  method sufijo() = "Izquierda"
  
  method orientacionConstante(personaje) = personaje.IZQUIERDA()
}

object derecha {
  method puedeMover(
    personaje
  ) = (topeDer.position().x() + 24) > personaje.position().x()
  
  method mover(personaje) = personaje.mover(1, 0)
  
  method sufijo() = "Derecha"
  
  method orientacionConstante(personaje) = personaje.DERECHA()
}

object arriba {
  method puedeMover(
    personaje
  ) = (topeArriba.position().y() + 14) > personaje.position().y()
  
  method mover(personaje) = personaje.mover(0, 1)
  
  method sufijo() = "Espaldas"
  
  method orientacionConstante(personaje) = personaje.ARRIBA()
}

object abajo {
  method puedeMover(
    personaje
  ) = (topeArriba.position().y() + 1) < personaje.position().y()
  
  method mover(personaje) = personaje.mover(0, -1)
  
  method sufijo() = "Default"
  
  method orientacionConstante(personaje) = personaje.ABAJO()
}