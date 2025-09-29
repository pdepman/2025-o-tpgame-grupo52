import hitbox.*
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
    if(not(pared.todopuedeMoverA(nueva.x(),nueva.y()))and not(self.hayColisionEn(nueva))){
    self.position(nueva)
  }}

  method hayColisionEn(destino) {
  return (destino == chef2.position()) 
  }

  
  method loLevanta(comida) {
    game.say(self, comida.nombre())
    game.removeVisual(comida)
    self.llevar(comida)
    cambio = "4"
    var pos = self.position()
    self.position(game.at(pos.x() - 1, pos.y() - 1))
  }
  
  method llevar(comida) {
    sostiene.add(comida)
  }
  

  method configurarTeclas() {
    // izquierda
    keyboard.a().onPressDo(
      { 
        if ((topeIzq.position().x() + 8) < self.position().x()) self.mover(-1, 0)
        orientacion = IZQUIERDA
      }
    )
    // derecha
    keyboard.d().onPressDo(
      { 
        if ((topeDer.position().x() + 24) > self.position().x()) self.mover(1,0)
        orientacion = DERECHA
      }
    )
    // abajo
    keyboard.s().onPressDo(
      { 
        if ((topeArriba.position().y() + 1) < self.position().y()) self.mover( 0,-1)
        orientacion = ABAJO
      }
    )
    // arriba
    keyboard.w().onPressDo(
      { 
        if ((topeArriba.position().y() + 14) > self.position().y()) self.mover(0,1)
        orientacion = ARRIBA
      }
    )
  }
}
class Personajetest2 inherits Personajetest{


  override method configurarTeclas() {
    // izquierda
    keyboard.left().onPressDo(
      { 
        if ((topeIzq.position().x() + 8) < self.position().x()) self.mover(-1, 0)
        orientacion = IZQUIERDA
      }
    )
    // derecha
    keyboard.right().onPressDo(
      { 
        if ((topeDer.position().x() + 24) > self.position().x()) self.mover(1,0)
        orientacion = DERECHA
      }
    )
    // abajo
    keyboard.down().onPressDo(
      { 
        if ((topeArriba.position().y() + 1) < self.position().y()) self.mover( 0,-1)
        orientacion = ABAJO
      }
    )
    // arriba
    keyboard.up().onPressDo(
      { 
        if ((topeArriba.position().y() + 14) > self.position().y()) self.mover(0,1)
        orientacion = ARRIBA
      }
    )
  }
  override method hayColisionEn(destino) {
  return (destino == chef1.position()) 
  }

}
const chef1= new Personajetest(position= game.at(12, 3))
const chef2= new Personajetest2(position = game.at(20, 3))