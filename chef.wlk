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
  var sufijo = "Default"
  method position() = position
  
  method orientacion() = orientacion 

  method position(nuevaPosition) {
    position = nuevaPosition
  }
  
  method image() = "chef" + sufijo + ".png"
  
  method mover(dx, dy) {
    var nueva = game.at(position.x() + dx, position.y() + dy)
    if ((not pared.todopuedeMoverA(nueva.x(),nueva.y())) and (not self.hayColisionEn(nueva))) 
    self.position(nueva)
    self.image()
    self.moverComida() //Cuando se agarra un objeto, este "acompaña" al chef donde este mira (adelante de el)
  }
  
  method inventarioVacio() = sostiene.isEmpty()

  method moverComida(){
    if(!self.inventarioVacio()){ //Si tenemos un objeto agarrado
      var posChefActual = self.position()
      var sentidoX = 0
      var sentidoY = 0
      if(self.orientacion() == 1) { sentidoX = 1}
      if(self.orientacion() == 2) { sentidoY = -1}
      if(self.orientacion() == 3) { sentidoY = 1}
      if(self.orientacion() == 4) { sentidoX = -1}
      pan.position(posChefActual.x() + sentidoX , posChefActual.y() + sentidoY)
    }
  }

  method hayColisionEn(destino) = destino == chef2.position()
  
  method configurarTeclas() {
    //izquierda
    keyboard.a().onPressDo(
      { 
        if ((topeIzq.position().x() + 8) < self.position().x()) 
        self.mover(-1,0)
        orientacion = IZQUIERDA
        sufijo = "Izquierda"
      }
    )
    // derecha
    keyboard.d().onPressDo(
      { 
        if ((topeDer.position().x() + 24) > self.position().x()) 
        self.mover(1,0)
        orientacion = DERECHA
        sufijo = "Derecha"
      }
    )
    // abajo
    keyboard.s().onPressDo(
      { 
        if ((topeArriba.position().y() + 1) < self.position().y()) 
        self.mover(0,-1)
        orientacion = ABAJO
        sufijo = "Default"
      }
    )
    // arriba
    keyboard.w().onPressDo(
      { 
        if ((topeArriba.position().y() + 14) > self.position().y()) 
        self.mover(0,1)
        orientacion = ARRIBA
        sufijo = "Espaldas"
      }
    )
    keyboard.e().onPressDo({ self.tomarComida() })
  }
  
  method tienePan() = sostiene.any({ c => c == pan })
  
  method tomarComida() {
    if (self.inventarioVacio()) { //Si no tiene nada
      if (self.hayPan()) {
        //game.removeVisual(pan)
        pan.estaEnInventario(true) //Actualizamos la comida para decir que está en el inventario 
        self.llevar(pan)
        cambio = "4"
        //game.addVisual(pan)
        //self.moverComida()
      }
    }
    else{
      //game.addVisual(pan)
      var posComida = self.position()
      pan.position(posComida)
      self.quitar(pan)
      cambio = "3"
      //var pos = self.position()
      self.position(game.at(posComida.x() + 1, posComida.y()))
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
        if ((topeIzq.position().x() + 8) < self.position().x()) 
        self.mover(-1,0)
        orientacion = IZQUIERDA
        sufijo = "Izquierda"
      }
    )
    // derecha
    keyboard.right().onPressDo(
      { 
        if ((topeDer.position().x() + 24) > self.position().x()) 
        self.mover(1,0)
        orientacion = DERECHA
        sufijo = "Derecha"
      }
    )
    // abajo
    keyboard.down().onPressDo(
      { 
        if ((topeArriba.position().y() + 1) < self.position().y()) 
        self.mover(0,-1)
        orientacion = ABAJO
        sufijo = "Default"
      }
    )
    // arriba
    keyboard.up().onPressDo(
      { 
        if ((topeArriba.position().y() + 14) > self.position().y()) 
        self.mover(0,1)
        orientacion = ARRIBA
        sufijo = "Espaldas"
      }
    )
    keyboard.enter().onPressDo({ self.tomarComida() })
  }
  
  override method hayColisionEn(destino) = destino == chef1.position()
}

const chef1 = new Personajetest(position = game.at(12, 3))

const chef2 = new Personajetest2(position = game.at(20, 3))