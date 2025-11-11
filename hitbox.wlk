import elementosDeCocina.*
import comida.*
import spawn.*
import chef.*

const chefs=[jugador1,jugador2]

class Bloque {
  var property position = game.at(5, 5)
  method image() = 'mesa.png'

  method puedeMoverA(destino) = destino ==self.position() 

  method initialize() {
    pared.registrarbloque(self)
    game.addVisual(self)
  }
 
  
}

const mesa1 =new Bloque (position=game.at(8,4))
const mesa2=new Bloque (position=game.at(8,5))
const mesa3=new Bloque (position=game.at(8,7))
const mesa4=new Bloque (position=game.at(8,8))
const mesa5=new Bloque (position=game.at(10,5))
const mesa6=new Bloque (position=game.at(10,6))
const mesa7=new Bloque (position=game.at(10,7))
const mesa8=new Bloque (position=game.at(15,4))
const mesa9=new Bloque (position=game.at(15,5))
const mesa10=new Bloque (position=game.at(15,7))
const mesa11=new Bloque (position=game.at(15,8))
const mesa12=new Bloque (position=game.at(13,5))
const mesa13=new Bloque (position=game.at(13,6))
const mesa14=new Bloque (position=game.at(13,7))

object pared {
  const obstaculos = []

   method registrarBloque(unaComida) {
    obstaculos.add(unaComida)
  }
  method registrarbloque(bloque) {
    obstaculos.add(bloque)
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

const topeArriba = new Tope(position=game.at(0, 11))

const topeIzq = new Tope(position=game.at(5, 0))

const topeDer = new Tope(position=game.at(18, 0))
