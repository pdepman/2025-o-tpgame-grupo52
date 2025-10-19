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
    var property position = game.at(12, 11)

    var property comida =""

    method comida(cosa){
        comida = cosa
    }



    method image() = "plato"+comida+".png" 

    var ingredientes  = []

    method agregarIngrediente(unaComida) {
        if (unaComida != null) {
            ingredientes.add(unaComida)
        }
    }

    method ingredientes() = ingredientes

    method intentarAceptar(puntos) {
    var posiblesRecetas = [hamburguesa_simple,hamburguesa_completa,hamburguesa_huevo,sandwich_bacon,ensalada,desayuno_bacon_huevo]
    var condicion = posiblesRecetas.any({receta => receta.completa(self.ingredientes())})
        if (condicion){
            ingredientes.clear()
            scoreManager.sumar(10)
            marcador.actualizar()

            //return true
        } 
    }
}

const plato = new Plato()