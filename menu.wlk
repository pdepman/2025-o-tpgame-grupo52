import teclasYposiciones.*
import receta.*
import hitbox.*
import chef.*
import comida.*
import elementosDeCocina.*
import score.*
import temporizador.*
import spawn.*



object menu {

  var opciones = [coop,versus,recetas]
  const cursor = puntero
  
  method position()= game.at(0, 0)
  method image() = "menu2.png"

  method iniciar() {
    game.addVisual(self)
    configTeclas.setModoMenu()
    puntero.iniciar()
  }

  method cerrar() {
    game.removeVisual(self)
    puntero.eliminar()
    configTeclas.setModoJuego()
  }

  method moverCursorArriba() = cursor.subir()
  method moverCursorAbajo() = cursor.bajar()

  method seleccionarOpcion() {
    const opcion = opciones.get(cursor.numeroEleccion())
    opcion.iniciar()
  }
}
object puntero {

  var property position = game.at(8, 3)

  const property posiciones = [
    game.at(8, 9),  // Coop
    game.at(8, 6),  // Versus
    game.at(8, 3)  // Recetas
  ]

  var property numeroEleccion = 0

  method iniciar() {
    numeroEleccion = 0
    self.position(posiciones.get(0))
    game.addVisual(self)
  }



  method eliminar() {
    game.removeVisual(self)
  }

  method image() = "puntero.png"

  method bajar() {
    numeroEleccion += 1
    if (numeroEleccion >= posiciones.size()) {
      numeroEleccion = 0  
    }
    self.position(posiciones.get(numeroEleccion))
  }

  method subir() {
    numeroEleccion -= 1
    if (numeroEleccion < 0) {
      numeroEleccion = posiciones.size() - 1
    }
    self.position(posiciones.get(numeroEleccion))
  }
}

object versus{
  const objetos=[]
  const chefs=[]

  method iniciar(){
    menu.cerrar()
    configTeclas.setModoJuego()
    self.inciarObjetos()
    self.inciarChefs()
    tick.start()
    temporizador.iniciar()
  }
  method inciarObjetos(){
    objetos.forEach({objeto=>objeto.iniciar()})
  }
  method inciarChefs(){
    chefs.forEach({chef=>chef.iniciar()})
  }
}
 const tick = game.tick(10000, { sistemaPedidos.generarPedido() }, false)

 object coop{
  const objetos=[generadorPan,generadorCarne,generadorHuevo,generadorPuerco,generadorTomate,generadorLechuga,plato1,plato2,plato3,plato4,tacho1,tacho2,tabla1,tabla3,tabla4,marcador1,marcador2]
  const chefs=[jugador1,jugador2]

  method iniciar(){
    menu.cerrar()
    configTeclas.setModoJuego()
    self.inciarObjetos()
    self.inciarChefs()
    tick.start()
    temporizador.iniciar()
    game.addVisual(temporizadorVisual)
  }
  method inciarObjetos(){
    objetos.forEach({objeto=>objeto.iniciar()})
  }
  method inciarChefs(){
    chefs.forEach({chef=>chef.iniciar()})
  }

 }
 object recetas{
  
  method iniciar(){}

 }




	
