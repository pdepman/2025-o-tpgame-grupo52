import chef.*
import hitbox.*
import menu.*

object configTeclas {

  var tecladoActual = tecladoJuego

  method iniciar() {

    keyboard.w().onPressDo({ tecladoActual.w() })
    keyboard.s().onPressDo({ tecladoActual.s() })
    keyboard.a().onPressDo({ tecladoActual.a() })
    keyboard.d().onPressDo({ tecladoActual.d() })
    keyboard.e().onPressDo({ tecladoActual.e() })
    keyboard.q().onPressDo({ tecladoActual.q() })

    keyboard.up().onPressDo({ tecladoActual.up() })
    keyboard.down().onPressDo({ tecladoActual.down() })
    keyboard.left().onPressDo({ tecladoActual.left() })
    keyboard.right().onPressDo({ tecladoActual.right() })
    keyboard.enter().onPressDo({ tecladoActual.enter() })
    keyboard.shift().onPressDo({ tecladoActual.shift() })


    keyboard.m().onPressDo({ tecladoActual.abrirMenu() })

    keyboard.space().onPressDo({ tecladoActual.salirguia() })
  }

  method setModoJuego() {
    tecladoActual = tecladoJuego
  }

    method setModoMenu() {
      tecladoActual = tecladoMenu
    }
   method setModoGuia() {
      tecladoActual = tecladoGuia
    }
}
object tecladoJuego {

  method w() { jugador1.intentarMover(arriba)}
  method s() { jugador1.intentarMover(abajo) }
  method a() { jugador1.intentarMover(izquierda) }
  method d() { jugador1.intentarMover(derecha) }
  method e() { jugador1.tomarComida() }
  method q() { jugador1.intentarInteraccion() }

  method up() { jugador2.intentarMover(arriba) }
  method down() { jugador2.intentarMover(abajo) }
  method left() { jugador2.intentarMover(izquierda) }
  method right() { jugador2.intentarMover(derecha)  }
  method enter() { jugador2.tomarComida() }
  method shift() { jugador2.intentarInteraccion() }
  method abrirMenu() {menu.iniciar()}
  method reiniciar() { }
  method salirguia() {}
}
object tecladoMenu {

  method w() { menu.moverCursorArriba() }
  method s() { menu.moverCursorAbajo() }
  method enter() { menu.seleccionarOpcion()}

  // Las demás teclas no hacen nada
  method a() {}
  method d() {}
  method q() {}
  method e() {}
  method up() {}
  method down() {}
  method left() {}
  method right() {}
  method shift() {}
  method abrirMenu() {}
  method reiniciar() {}
  method salirguia() {}
}  

object tecladoGuia{
  method d() {recetas.derecha()}
  method a() {recetas.izquierda()}
  method salirguia() {recetas.salir()}

  // Las demás teclas no hacen nada
  method s() {}
  method w() {}
  method q() {}
  method e() {}
  method up() {}
  method down() {}
  method left() {}
  method right() {}
  method shift() {}
  method abrirMenu() {}
  method reiniciar() {}
}
  
object izquierda {
  const position = game.at(-1, 0)
  
  method puedeMover(
    personaje
  ) = topeIzq.position().x() < personaje.position().x()
  
  method mover(personaje) = personaje.mover(self.desplazamiento())
  
  method sufijo() = "Izquierda"
  
  method desplazamiento() = position
}

object derecha {
  const position = game.at(1, 0)
  
  method puedeMover(
    personaje
  ) = topeDer.position().x() > personaje.position().x()
  
  method mover(personaje) = personaje.mover(self.desplazamiento())
  
  method sufijo() = "Derecha"
  
  method desplazamiento() = position
}

object arriba {
  const position = game.at(0, 1)
  
  method puedeMover(
    personaje
  ) = topeArriba.position().y() > personaje.position().y()
  
  method mover(personaje) = personaje.mover(self.desplazamiento())
  
  method sufijo() = "Espaldas"
  
  method desplazamiento() = position
}

object abajo {
  const position = game.at(0, -1)
  
  method puedeMover(
    personaje
  ) = topeAbajo.position().y() < personaje.position().y()
  
  method mover(personaje) = personaje.mover(self.desplazamiento())
  
  method sufijo() = "Default"
  
  method desplazamiento() = position
}

