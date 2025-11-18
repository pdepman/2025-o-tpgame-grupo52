import elementosDeCocina.*
import hitbox.*


class Comida {
  var property position = game.origin()

  var faltaCocinar =true
  var faltaCortar =true

  const property esPlato = false 

  method faltaCocinar(param) {faltaCocinar=param}

  method faltaCortar(param) {faltaCortar=param}
    

  var ocupado = false 
  const  property nombre 
  var image = apodo + ".png" 
  
  method initialize() {
    cocina.registrarComida(self)
  }
  var property apodo = nombre
  method ingredienteListo()=not faltaCocinar and not faltaCortar


   method cambiarNombre(nuevoNombre) {
    apodo = nuevoNombre
  }
  
  method cambiarImagen(nuevaImagen) {
    image = nuevaImagen
    game.removeVisual(self)
    game.addVisual(self)
  }
    

  method ocupado() = ocupado
  
  method ocupado(parametro) {
    ocupado = parametro 
  } 
  var estaEnInventario = false 

  method estaEnInventario() = estaEnInventario
  
  method estaEnInventario(parametro) {
    estaEnInventario = parametro 
  } 

  method image() = apodo + ".png" 

  method position(newPosX, newPosY){
    position = game.at(newPosX,newPosY)  
  }

  method esMovible()= true

  method moverAlaEsquina(){position = game.at(1,1)}
  method reiniciar(){
    self.moverAlaEsquina()
  game.removeVisual(self)}
}

const pan = new Comida (faltaCocinar= false , faltaCortar=false, nombre='pan')
const lechuga_cortada = new Comida (faltaCocinar= false , faltaCortar=false, nombre='lechuga_cortada')
const tomate = new Comida ( faltaCocinar= false , faltaCortar=false, nombre='tomate')
const carne_cortada_cocinado = new Comida (faltaCocinar= false , faltaCortar=false, nombre='carne_cortada_cocinado')
const puerco_cortada_cocinado = new Comida (faltaCocinar= false , faltaCortar=false, nombre='puerco_cortada_cocinado')
const huevo_cocinado = new Comida ( faltaCocinar= false , faltaCortar=false, nombre='huevo_cocinado')
const puerco_cortada = new Comida (faltaCortar=false, nombre='puerco_cortada')
const carne = new Comida ( nombre='carne')
const huevo = new Comida ( faltaCortar=false, nombre='huevo')
const lechuga = new Comida ( faltaCocinar= false , nombre='lechuga')
const carne_cortada = new Comida ( faltaCortar=false, nombre='carne_cortada')
const puerco = new Comida ( nombre='puerco')

