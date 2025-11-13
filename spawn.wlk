import comida.*
import wollok.game.*
import hitbox.* 
import chef.*
import elementosDeCocina.*



class GeneradorComida {
  var property position
  const property tipoComida  
  var fCocinar =true
  var fCortar =true

  method image() = 'generador_'+ tipoComida +'.png'

  method generar() {
    const nueva = new Comida (position = position,faltaCocinar= fCocinar ,faltaCortar= fCortar,nombre= tipoComida )
    game.addVisual(nueva)
  }
  method interactuarCon(chef) {
    self.generar()
  }

  method puedeMoverA(destino) = destino ==self.position() 
  
  method initialize() {
    cocina.registrarobjetosInteractivos(self)
    pared.registrarbloque(self)
  }

}

const generadorPan = new GeneradorComida(position =  game.at(8,6),fCocinar= false , fCortar=false, tipoComida = 'pan')
const generadorCarne =  new GeneradorComida(position = game.at(10,8), tipoComida = 'carne')
const generadorLechuga = new GeneradorComida(position = game.at(13,4),fCocinar= false , tipoComida = 'lechuga')
const generadorHuevo = new GeneradorComida(position = game.at(10,4), fCortar=false, tipoComida = 'huevo')
const generadorPuerco = new GeneradorComida(position = game.at(13,8), tipoComida = 'puerco')
const generadorTomate = new GeneradorComida(position = game.at(15,6), fCocinar= false , fCortar=false,tipoComida = 'tomate')


const generadores = [
 generadorPan,generadorCarne,generadorLechuga,generadorHuevo,generadorPuerco,generadorTomate]