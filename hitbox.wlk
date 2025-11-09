import elementosDeCocina.*
import comida.*
import spawn.*



class Bloque {
  var property position = game.at(5, 5)
  method image() = 'pan.png'

  method puedeMoverA(destino) = destino ==self.position() 
  
}

const duro =new Bloque (position=game.at(16,5))
const duro2 =new Bloque (position=game.at(17,5))

object pared {
  const obstaculos = [duro, duro2, cajon,tacho]

   method registrarBloque(unaComida) {
    obstaculos.add(unaComida)
  }

  
  method obstaculos() = obstaculos
  method todopuedeMoverA(destino) = obstaculos.any({obstaculo=>obstaculo.puedeMoverA(destino)})

}

class Tope {
  var property position = game.origin()
  
  method ubicarEn(unaUbicacion) {
    self.position(unaUbicacion)
  }
}

const topeAbajo = new Tope(position=game.at(0, 2))

const topeArriba = new Tope(position=game.at(0, 12))

const topeIzq = new Tope(position=game.at(8, 0))

const topeDer = new Tope(position=game.at(24, 0))
