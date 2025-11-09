import comida.*
import wollok.game.*
import hitbox.* 
import chef.*



class GeneradorComida {
  var property position
  const property tipoComida  
  var fCocinar =true
  var fCortar =true

  method image() = 'cajon.png'

  method generar() {
    const nueva = new Comida (position = position,faltaCocinar= fCocinar ,faltaCortar= fCortar,nombre= tipoComida )
    game.addVisual(nueva)
  }
  method interactuarCon(chef) {
    self.generar()
  }
}

const generadorPan = new GeneradorComida(position =  game.at(18,11),fCocinar= false , fCortar=false, tipoComida = 'pan')
const generadorCarne =  new GeneradorComida(position = game.at(17,11), tipoComida = 'carne')
const generadorLechuga = new GeneradorComida(position = game.at(16,11),fCocinar= false , tipoComida = 'lechuga')
const generadorHuevo = new GeneradorComida(position = game.at(15,11), fCortar=false, tipoComida = 'huevo')
const generadorPuerco = new GeneradorComida(position = game.at(14,11), tipoComida = 'puerco')
const generadorTomate = new GeneradorComida(position = game.at(13,11), fCocinar= false , fCortar=false,tipoComida = 'tomate')


const generadores = [
 generadorPan,generadorCarne,generadorLechuga,generadorHuevo,generadorPuerco,generadorTomate]