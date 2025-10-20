import comida.*
import receta.*
import score.*

class Cajon{
    var property position = game.center()
    method image() ='cajon.png'


    method puedeMoverA(destinox,destinoy) = destinox==self.position().x() and destinoy==self.position().y()
    
    method aparecerIngrediente() {
    if (not(self.estaOcupado())) {
      game.addVisual(pan)
    }
  
    }

    method estaOcupado() = pan.position() == self.position()
    

}
const cajon = new Cajon (position = game.at(10,10))

class Tacho{
    var property position = game.center()
    method image() ='tacho.png'


    method puedeMoverA(destinox,destinoy) = destinox==self.position().x() and destinoy==self.position().y()
    
    method aparecerIngrediente() {
    if (not(self.estaOcupado())) {
      game.addVisual(pan)
    }
  
    }

    method estaOcupado() = pan.position() == self.position()
    

}

const tacho = new Tacho (position = game.at(10,5))




class Plato {    
    const ingredientes  = []
    var property position = posicionOriginal
    const property posicionOriginal 
    var estaEnInventario = false 
    method estaEnInventario() = estaEnInventario
    method estaEnInventario(param) {
    estaEnInventario = param 
  } 


  method position(newPosX, newPosY){
    position = game.at(newPosX,newPosY)  
  }

    method cantidad()=ingredientes.size()



    method image() = "plato"+self.cantidad()+".png" 

 

    method agregarIngrediente(unaComida) {
        if (unaComida != null) {
            ingredientes.add(unaComida)
        }
    }

    method ingredientes() = ingredientes

    method intentarAceptar() {
        if (sistemaDeRecetas.completita(ingredientes)){
            marcador.actualizar()
            self.volver()
            ingredientes.clear()

            //return true
        } 
    }

    method eliminarComida(){
      ingredientes.clear()
      self.volver()
    }
    method volver(){
    position = posicionOriginal
  }
}

const plato1 = new Plato(posicionOriginal= game.at(12, 11))
const plato2 = new Plato(posicionOriginal =game.at(19, 11))
