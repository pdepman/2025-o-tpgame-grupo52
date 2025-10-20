import elementosDeCocina.*
import comida.*


class Bloque {
  var property position = game.at(5, 5)
  method image() = 'pan.png'

  method puedeMoverA(destinox,destinoy) = destinox==self.position().x() && destinoy==self.position().y()
  
}

const duro =new Bloque (position=game.at(16,5))
const duro2 =new Bloque (position=game.at(17,5))

object pared {
  const obstaculos = [duro, duro2, cajon,tacho]
  
  method obstaculos() = obstaculos
  method todopuedeMoverA(destinox,destinoy) = obstaculos.any({obstaculo=>obstaculo.puedeMoverA(destinox,destinoy)})

}

class Tope {
  var property position = game.origin()
  
  method ubicarEn(unaUbicacion) {
    self.position(unaUbicacion)
  }
}

const topeAbajo = new Tope(position=game.at(0, 1))

const topeArriba = new Tope(position=game.at(0, 14))

const topeIzq = new Tope(position=game.at(8, 0))

const topeDer = new Tope(position=game.at(24, 0))