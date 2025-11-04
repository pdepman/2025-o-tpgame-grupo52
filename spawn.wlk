import comida.*
import wollok.game.*
import hitbox.* 
import chef.*


class Generador{
  var property position = game.center()
  method image() = 'cajon.png'
  method puedeMoverA(destino) = destino == self.position()

}


const generador = new Generador()
class GeneradorComida {
  var property position
  const property tipoComida  
  method image() = 'cajon.png'

  method generar() {
    const nueva = new Comida (position = position, cortable= false , cocinable=false, nombre= tipoComida )
    game.addVisual(nueva)
  }
}

const generadorPan = new GeneradorComida(position =  game.at(18,11), tipoComida = 'pan')
const generadorCarne =  new GeneradorComida(position = game.at(17,11), tipoComida = 'carne')
const generadorLechuga = new GeneradorComida(position = game.at(16,11), tipoComida = 'lechuga')
const generadorHuevo = new GeneradorComida(position = game.at(15,11), tipoComida = 'huevo')
const generadorPuerco = new GeneradorComida(position = game.at(14,11), tipoComida = 'puerco')
const generadorTomate = new GeneradorComida(position = game.at(13,11), tipoComida = 'tomate')


const generadores = [
 generadorPan,generadorCarne,generadorLechuga,generadorHuevo,generadorPuerco,generadorTomate]