object personajetest {
  var cambio = "3"
  var sostiene = []
  var ultimaPos = position
  var property position = game.at(12, 3)
  
  method image() = ("test" + cambio) + ".png"
  
  method mover(dx, dy) {
    position = game.at(position.x() + dx, position.y() + dy)
  }
  
  method loLevanta(comida) {
    game.say(self, comida.nombre())
    game.removeVisual(comida)
    self.llevar(comida)
    cambio = "4"
    var pos = self.position()
    self.position(game.at(pos.x() - 1, pos.y() - 1))
  }
  
  method retroceder() {
    position = ultimaPos
  }
  
  method llevar(comida) {
    sostiene.add(comida)
  }
  
  method configurarTeclas() {
    //Left
    keyboard.a().onPressDo(
      { if ((topeIzq.position().x() + 8) < self.position().x()) self.position(
            self.position().left(1)
          ) }
    )
    //right
    keyboard.d().onPressDo(
      { if ((topeDer.position().x() + 24) > self.position().x()) self.position(
            self.position().right(1)
          ) }
    )
    //down
    keyboard.s().onPressDo(
      { if ((topeAbajo.position().y() + 1) < self.position().y()) self.position(
            self.position().down(1)
          ) }
    )
    //up
    keyboard.w().onPressDo(
      { if ((topeArriba.position().y() + 14) > self.position().y())
          self.position(self.position().up(1)) }
    )
  }
}

object personajetest2 {
  var position = game.at(20, 3)
  var cambio = "3"
  var sostiene = []
  var ultimaPos = position
  
  method image() = ("test" + cambio) + ".png"
  
  method position() = position
  
  method position(nuevaPosition) {
    position = nuevaPosition
  }
  
  method loLevanta(comida) {
    game.say(self, comida.nombre())
    game.removeVisual(comida)
    self.llevar(comida)
    cambio = "4"
    
    var pos = self.position()
    self.position(game.at(pos.x() - 1, pos.y() - 1))
  }
  
  method mover(dx, dy) {
    position = game.at(position.x() + dx, position.y() + dy)
  }
  
  method retroceder() {
    position = ultimaPos
  }
  
  method llevar(comida) {
    sostiene.add(comida)
  }
  method configurarTeclas() {
    //Left
    keyboard.left().onPressDo(
      { if ((topeIzq.position().x() + 8) < self.position().x()) self.position(
            self.position().left(1)
          ) }
    )
    //right
    keyboard.right().onPressDo(
      { if ((topeDer.position().x() + 24) > self.position().x()) self.position(
            self.position().right(1)
          ) }
    )
    //down
    keyboard.down().onPressDo(
      { if ((topeAbajo.position().y() + 1) < self.position().y()) self.position(
            self.position().down(1)
          ) }
    )
    //up
    keyboard.up().onPressDo(
      { if ((topeArriba.position().y() + 14) > self.position().y())
          self.position(self.position().up(1)) }
    )
  }
}

class Tope {
  var property position = game.origin()
  
  method ubicarEn(unaUbicacion) {
    self.position(unaUbicacion)
  }
}

const topeAbajo = new Tope()

const topeArriba = new Tope()

const topeIzq = new Tope()

const topeDer = new Tope()