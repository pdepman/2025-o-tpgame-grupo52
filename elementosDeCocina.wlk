import comida.*
import receta.*
import score.*

class Cajon{
    var property position = game.center()
    const tipo = 'pan'
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


// object estufa{
//     var position = game.at(10,10)
//     method image() = 'test3.jpg'

// }

//  method aparecer() {
//         position = self.encontrarSillaDesocupada()
//         cliente.fantasmasVisibles().add(self)
//         game.addVisual(self)




class Plato {    
    var ingredientes  = []
    var cantidad =0 
    var property position = game.at(12, 11)
    var estaEnInventario = false 
    method estaEnInventario() = estaEnInventario
    method estaEnInventario(Param) {
    estaEnInventario = Param 
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
            plato.position(12, 11)
            ingredientes.clear()

            //return true
        } 
    }
}

const plato = new Plato()