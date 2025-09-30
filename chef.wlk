import hitbox.*
import wollok.game.*
import comida.*
import elementosDeCocina.*

class Personajetest {
  var cambio = "3"
  var sostiene = []
  var orientacion = 1
  var position = game.origin()
  const DERECHA = 1
  const ABAJO = 2
  const ARRIBA = 3
  const IZQUIERDA = 4
  
  method position() = position
  
  method position(nuevaPosition) {
    position = nuevaPosition
  }
  
  method image() = ("test" + cambio) + ".png"
  
  method mover(dx, dy) {
    var nueva = game.at(position.x() + dx, position.y() + dy)
    if ((not pared.todopuedeMoverA(
        nueva.x(),
        nueva.y()
      )) and (not self.hayColisionEn(nueva))) self.position(nueva)
  }
  
  method hayColisionEn(destino) = destino == chef2.position()
  
  method configurarTeclas() {
    // izquierda
    keyboard.a().onPressDo(
      { 
        if ((topeIzq.position().x() + 8) < self.position().x()) self.mover(
            -1,
            0
          )
        orientacion = IZQUIERDA
      }
    )
    // derecha
    keyboard.d().onPressDo(
      { 
        if ((topeDer.position().x() + 24) > self.position().x()) self.mover(
            1,
            0
          )
        orientacion = DERECHA
      }
    )
    // abajo
    keyboard.s().onPressDo(
      { 
        if ((topeArriba.position().y() + 1) < self.position().y()) self.mover(
            0,
            -1
          )
        orientacion = ABAJO
      }
    )
    // arriba
    keyboard.w().onPressDo(
      { 
        if ((topeArriba.position().y() + 14) > self.position().y()) self.mover(
            0,
            1
          )
        orientacion = ARRIBA
      }
    )
    keyboard.e().onPressDo({ self.tomarComida() })
  }
  
  method tienePan() =sostiene.any({ c => c == pan })
  
  
  method tomarComida() {
    if (not(self.tienePan())) {
      if (self.hayPan()) {
        game.removeVisual(pan)
        self.llevar(pan)
        cambio = "4"
        var pos = self.position()
        self.position(game.at(pos.x() - 1, pos.y() - 1))
      }
    }
    else{
      game.addVisual(pan)
      pan.position(self.position())
      self.quitar(pan)
      cambio = "3"
      var pos = self.position()
        self.position(game.at(pos.x() + 1, pos.y() + 1))
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

class Personajetest2 inherits Personajetest {
  override method configurarTeclas() {
    // izquierda
    keyboard.left().onPressDo(
      { 
        if ((topeIzq.position().x() + 8) < self.position().x()) self.mover(
            -1,
            0
          )
        orientacion = IZQUIERDA
      }
    )
    // derecha
    keyboard.right().onPressDo(
      { 
        if ((topeDer.position().x() + 24) > self.position().x()) self.mover(
            1,
            0
          )
        orientacion = DERECHA
      }
    )
    // abajo
    keyboard.down().onPressDo(
      { 
        if ((topeArriba.position().y() + 1) < self.position().y()) self.mover(
            0,
            -1
          )
        orientacion = ABAJO
      }
    )
    // arriba
    keyboard.up().onPressDo(
      { 
        if ((topeArriba.position().y() + 14) > self.position().y()) self.mover(
            0,
            1
          )
        orientacion = ARRIBA
      }
    )
    keyboard.enter().onPressDo({ self.tomarComida() })
  }
  
  override method hayColisionEn(destino) = destino == chef1.position()
}

const chef1 = new Personajetest(position = game.at(12, 3))

const chef2 = new Personajetest2(position = game.at(20, 3))