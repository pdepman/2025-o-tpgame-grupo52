import chef.*

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

    // // Cambio de modo (no depende del tecladoActual)
    // keyboard.m().onPressDo({ juego.abrirMenu() })
    // keyboard.escape().onPressDo({ juego.cerrarMenu() })
  }

  method setModoJuego() {
    tecladoActual = tecladoJuego
  }

//   method setModoMenu() {
//     tecladoActual = tecladoMenu
//   }
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
}
// object tecladoMenu {

//   method w() { menu.moverCursorArriba() }
//   method s() { menu.moverCursorAbajo() }
//   method enter() { menu.seleccionarOpcion() }
//   method escape() { menu.cerrar() }

//   // Las demás teclas no hacen nada
//   method a() {}
//   method d() {}
//   method q() {}
//   method e() {}
//   method up() {}
//   method down() {}
//   method left() {}
//   method right() {}
//   method shift() {}
// }  method hayColisionEn(destino) = destino == jugador2.position()
  

