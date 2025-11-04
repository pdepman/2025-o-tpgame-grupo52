import hitbox.*
import wollok.game.*
import comida.*
import elementosDeCocina.*
import spawn.*

class Chef {
  var cambio = ""
  var sostiene = null
  var orientacion = derecha
  var position = game.origin()
  var sufijo = "Default"
  
  method position() = position
  
  method orientacion() = orientacion
  
  method position(nuevaPosition) {
    position = nuevaPosition
  }
  
  method direccionObjeto() =  orientacion.desplazamiento()

  method inventarioVacio() = sostiene == null
  
  method image() = (("chef" + sufijo) + cambio) + ".png"
  
  method mover(desplazamiento) {
    var nueva = game.at(position.x() + desplazamiento.x(), position.y() + desplazamiento.y())
    if ((not pared.todopuedeMoverA(nueva)) and (not self.hayColisionEn(nueva))) 
    self.position(nueva)
  }
  
  method moverComida(ingrediente) {
    if (!self.inventarioVacio()) {
      var posChefActual = self.position()
      var direccion

      direccion = self.direccionObjeto()

      ingrediente.position(
        posChefActual.x() + direccion.x(),
        posChefActual.y() + direccion.y() 
      )
    }
  }
  
  method hayColisionEn(destino) = destino == jugador2.position()
  

 method configurarTeclas() {
  self.teclas(
    keyboard.a(), 
    keyboard.d(), 
    keyboard.w(), 
    keyboard.s(), 
    keyboard.e(),
    keyboard.q()
  )
}

method teclas(teclaIzquierda, teclaDerecha, teclaArriba, teclaAbajo, teclaTomar,teclaInteractuar) {
  teclaIzquierda.onPressDo({ self.intentarMover(izquierda) })
  teclaDerecha.onPressDo({ self.intentarMover(derecha) })
  teclaArriba.onPressDo({ self.intentarMover(arriba) })
  teclaAbajo.onPressDo({ self.intentarMover(abajo) })
  teclaTomar.onPressDo({ self.tomarComida() })
  teclaInteractuar.onPressDo({ self.intentarGenerar()})
}
  
  method intentarMover(direccion) {
    if (orientacion == direccion) {
      if (direccion.puedeMover(self)) 
      direccion.mover(self)
    }
    sufijo = direccion.sufijo()
    orientacion = direccion
    self.moverComida(sostiene)
  }
  
method ingredienteCercano() {
  var posicionAdelante =  self.posicionAdelante()

  return cocina.comidas().find({ c => c.position() == posicionAdelante })
}

method intentarGenerar() {
  const posAdelante = self.posicionAdelante()
  const generadorCercano = generadores.find({ g => g.position() == posAdelante })

  if (generadorCercano != null) {
    generadorCercano.generar()
  }
}

method posicionAdelante() {
  var pos = self.position()
  if (orientacion == derecha) return pos.right(1)
  if (orientacion == izquierda) return pos.left(1)
  if (orientacion == arriba) return pos.up(1)
  if (orientacion == abajo) return pos.down(1)
  return pos
}

  method llevar(ingrediente) {
    sostiene = ingrediente
  }
  
  method quitar(ingrediente) {
    if (sostiene == ingrediente) {
      sostiene = null
    }
  }
  
  method tomarComida() {
    if (self.inventarioVacio()) {
      const ingredienteCercano = self.ingredienteCercano()
      if (ingredienteCercano != null) {
        ingredienteCercano.estaEnInventario(true)
        self.llevar(ingredienteCercano)
        cambio = "_agarro"
      }
    } else {
      const ingrediente = sostiene
      self.moverComida(ingrediente)
      self.quitar(ingrediente)
      cambio = ""
      
      const platoDestino = platos.find(
        { p => p.position() == ingrediente.position() }
      )
      
      if ((platoDestino != null) and (ingrediente != platoDestino)) {
        platoDestino.agregarIngrediente(ingrediente)
        game.removeVisual(ingrediente)
        ingrediente.volver()
        game.addVisual(ingrediente)
      }
      platos.forEach(
        { p =>
          if (p.position() == cajon.position()) p.intentarAceptar()
          if (p.position() == tacho.position()) p.eliminarComida()
        }
      )
    }
  }
}

class Chef2 inherits Chef {

override method configurarTeclas() {
  self.teclas(
    keyboard.left(), 
    keyboard.right(), 
    keyboard.up(), 
    keyboard.down(), 
    keyboard.enter(),
    keyboard.shift()
    
  )
}

override method hayColisionEn(destino) = destino == jugador1.position()
}

const jugador1 = new Chef(position = game.at(12, 3))
const jugador2 = new Chef2(position = game.at(20, 3))

object izquierda {
  const position = game.at(-1,0)
  method puedeMover(personaje) = topeIzq.position().x() < personaje.position().x()
  method mover(personaje) = personaje.mover(self.desplazamiento())
  method sufijo() = "Izquierda"
  method desplazamiento() = position  
}

object derecha {
  const position = game.at(1,0)
  method puedeMover(personaje) = topeDer.position().x() > personaje.position().x()
  method mover(personaje) = personaje.mover(self.desplazamiento())
  method sufijo() = "Derecha"
  method desplazamiento() = position  
}

object arriba {
  const position = game.at(0,1)
  method puedeMover(personaje) = topeArriba.position().y() > personaje.position().y()
  method mover(personaje) = personaje.mover(self.desplazamiento())
  method sufijo() = "Espaldas"
  method desplazamiento() = position  
}

object abajo {
  const position = game.at(0,-1)
  method puedeMover(personaje) = topeAbajo.position().y() < personaje.position().y()
  method mover(personaje) = personaje.mover(self.desplazamiento())
  method sufijo() = "Default"
  method desplazamiento() = position  
}



const platos = [plato1, plato2]

