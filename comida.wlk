

class Comida {
  var property position = posicionOriginal
  const property posicionOriginal 

  const cortable 
  const cocinable
  const property nombre 
  var estaEnInventario = false 

  method estaEnInventario() = estaEnInventario
  
  method estaEnInventario(Param) {
    estaEnInventario = Param 
  } 

  method volver(){
    position = posicionOriginal
  }

  method image() = nombre + ".png" 

  method position(newPosX, newPosY){
    position = game.at(newPosX,newPosY)  
  }
  
}

const pan = new Comida (posicionOriginal = game.at(18,11), cortable= false , cocinable=false, nombre='pan')
const lechuga_cortada = new Comida (posicionOriginal = game.at(17,11), cortable= false , cocinable=false, nombre='lechuga_cortada')
const tomate = new Comida (posicionOriginal = game.at(16,11), cortable= false , cocinable=false, nombre='tomate')
const paty_cocinado = new Comida (posicionOriginal = game.at(15,11), cortable= false , cocinable=false, nombre='paty_cocinado')
const bacon_cocinado = new Comida (posicionOriginal = game.at(14,11), cortable= false , cocinable=false, nombre='bacon_cocinado')
const huevo_cocinado = new Comida (posicionOriginal = game.at(13,11), cortable= false , cocinable=false, nombre='huevo_cocinado')
