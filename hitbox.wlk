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
  var obstaculos = [duro, duro2, cajon]
  
  method obstaculos() = obstaculos
  method todopuedeMoverA(destinox,destinoy) = obstaculos.any({obstaculo=>obstaculo.puedeMoverA(destinox,destinoy)})

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