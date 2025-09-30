import comida.*

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

     method estaOcupado() =pan.position()== self.position()
    

}
const cajon = new Cajon (position = game.at(18,11))


// object estufa{
//     var position = game.at(10,10)
//     method image() = 'test3.jpg'

// }

//  method aparecer() {
//         position = self.encontrarSillaDesocupada()
//         cliente.fantasmasVisibles().add(self)
//         game.addVisual(self)
