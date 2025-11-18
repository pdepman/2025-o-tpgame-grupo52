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
  var opciones = [coop, versus, recetas]
  const cursor = puntero
  
  method position() = game.at(0, 0)
  
  method image() = "menu3.png"
  
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
  
  method volverMenu(modo) {
    modo.quitarObjetos()
    modo.quitarChefs()
    modo.reiniciar()
    self.iniciar()
  }
}

object puntero {
  var property position = game.at(8, 3)
  const property posiciones = [
    game.at(8, 8),
    // Coop
    game.at(8, 5),
    // Versus
    game.at(8, 2) // Recetas
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

object versus {

  const objetos = [
    generadorPan, generadorCarne, generadorHuevo, generadorPuerco,
    generadorTomate, generadorLechuga,
    plato1, plato2, plato3, plato4,
    tacho1, tacho2,
    tabla1, tabla2, tabla3, tabla4,
    marcador1, marcador2
  ]

  const chefs = [jugador1, jugador2]

  method iniciar() {
    menu.cerrar()
    configTeclas.setModoJuego()
    tecladoJuego.modo(self)

    self.iniciarObjetos()
    self.iniciarChefs()


    tick.start()
    temporizador.modo(self)
    temporizador.iniciar()
  }



  method iniciarObjetos() {
    objetos.forEach({ obj => obj.iniciar() })
  }


  method iniciarChefs() {
    chefs.forEach({ chef => chef.iniciar() })
  }



  method reiniciarChefs() {
    chefs.forEach({ chef => chef.reiniciar() })
  }

  method quitarChefs() {
    chefs.forEach({ chef => chef.quitar() })
  }

  method juegoreiniciar() {
    self.reiniciarChefs()
    cocina.comidas().forEach({ comida => comida.reiniciar() })
    temporizador.reiniciar()
    sistemaPedidos.reiniciar()
    temporizador.borrarMensajeFinal()
    marcador1.iniciar()
    marcador2.iniciar()
  }



  method quitarObjetos() {
    objetos.forEach({ obj => obj.quitar() })
  }



method volverMenu() {
  marcador1.quitar()
marcador2.quitar()
 menu.iniciar()
configTeclas.setModoMenu()

}

}

const tick = game.tick(10000, { sistemaPedidos.generarPedido() }, false)

object coop {
   const objetos = [
    generadorPan, generadorCarne, generadorHuevo, generadorPuerco,
    generadorTomate, generadorLechuga,
    plato1, plato2, plato3, plato4,
    tacho1, tacho2,
    tabla1, tabla2, tabla3, tabla4,
    marcador
  ]

  const chefs = [jugador1, jugador2]

  method iniciar() {
    menu.cerrar()
    configTeclas.setModoJuego()
    tecladoJuego.modo(self)

    self.iniciarObjetos()
    self.iniciarChefs()

    tick.start()
    temporizador.modo(self)
    temporizador.iniciar()
  }



  method iniciarObjetos() {
    objetos.forEach({ obj => obj.iniciar() })
  }


  method iniciarChefs() {
    chefs.forEach({ chef => chef.iniciar() })
  }



  method reiniciarChefs() {
    chefs.forEach({ chef => chef.reiniciar() })
  }

  method quitarChefs() {
    chefs.forEach({ chef => chef.quitar() })
  }

  method juegoreiniciar() {
    self.reiniciarChefs()
    cocina.comidas().forEach({ comida => comida.reiniciar() })
    temporizador.reiniciar()
    sistemaPedidos.reiniciar()
    temporizador.borrarMensajeFinal()
    marcador.reiniciar()
    marcador.iniciar()
  }



  method quitarObjetos() {
    objetos.forEach({ obj => obj.quitar() })
  }

method volverMenu() {
marcador.quitar()
 menu.iniciar()
configTeclas.setModoMenu()
}}

object recetas {
  var pagina = 1
  
  method position() = game.at(3, 2)
  
  method image() = ("recetapag" + pagina) + ".png"
  
  method derecha() {
    if (pagina >= 4) {
      pagina = 4
    } else {
      pagina += 1
    }
  }
  
  method izquierda() {
    if (pagina <= 1) {
      pagina = 1
    } else {
      pagina -= 1
    }
  }
  
  method iniciar() {
    game.addVisual(self)
    configTeclas.setModoGuia()
  }
  
  method salir() {
    game.removeVisual(self)
    configTeclas.setModoMenu()
  }
}


	
