import elementosDeCocina.*

class Comida {
  var property position = game.origin()

  const cortable 
  const property cocinable
  const property nombre 

   method initialize() {
    cocina.registrarComida(self)
  }


  var estaEnInventario = false 

  method estaEnInventario() = estaEnInventario
  
  method estaEnInventario(parametro) {
    estaEnInventario = parametro 
  } 

  method image() = nombre + ".png" 

  method position(newPosX, newPosY){
    position = game.at(newPosX,newPosY)  
  }

  method esMovible()= true
}

const pan = new Comida (cortable= false , cocinable=false, nombre='pan')
const lechuga_cortada = new Comida (cortable= false , cocinable=false, nombre='lechuga_cortada')
const tomate = new Comida (cortable= false , cocinable=false, nombre='tomate')
const carne_cortada_cocinado = new Comida (cortable= false , cocinable=false, nombre='carne_cortada_cocinado')
const puerco_cortada_cocinado = new Comida (cortable= false , cocinable=false, nombre='puerco_cortada_cocinado')
const huevo_cocinado = new Comida ( cortable= false , cocinable=false, nombre='huevo_cocinado')
const puerco_cortada = new Comida ( cortable= false , cocinable=true, nombre='puerco_cortada')
const carne = new Comida (cortable= true , cocinable=false, nombre='carne')
const huevo = new Comida (cortable= false , cocinable=true, nombre='huevo')
const lechuga = new Comida (cortable= true , cocinable=false, nombre='lechuga')
const carne_cortada = new Comida (cortable= false , cocinable=true, nombre='carne_cortada')
const puerco = new Comida (cortable= true , cocinable=false, nombre='puerco')

