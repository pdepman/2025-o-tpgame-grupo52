import hitbox.*
import wollok.game.*
import comida.*
import elementosDeCocina.*
import spawn.*

class Chef {
  var cambio = ""
  const nombre 
  var sostiene = null
  var orientacion = derecha
  var property position = game.origin()
  var sufijo = "Default"


  method orientacion() = orientacion
  
  
  method direccionObjeto() =  orientacion.desplazamiento()

  method inventarioVacio() = sostiene == null
  
  method image() = ((nombre + sufijo) + cambio) + ".png"
  
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
  
  method hayColisionEn(destino) = chefs.any({chef=>chef.position()==destino})

  
const objetosInteractivos=[generadorPan,generadorCarne,generadorLechuga,generadorHuevo,generadorPuerco,generadorTomate,horno,tabla]

method intentarInteraccion() {
  const posAdelante = self.posicionAdelante()
  const objetoCercano = objetosInteractivos.find({ o => o.position() == posAdelante })

  if (objetoCercano != null) {
    objetoCercano.interactuarCon(self)
  }
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
    if (ingredienteCercano != null and not (ingredienteCercano.ocupado())) {
      ingredienteCercano.estaEnInventario(true)
      ingredienteCercano.ocupado(true)
      self.llevar(ingredienteCercano)
      cambio = "_agarro"
    }
  } else { 
    const ingrediente = sostiene

    if (sostiene == self.ingredienteCercano()) {

      const lugarOcupado = cocina.comidas().any({ i => i.position() == ingrediente.position() and i != ingrediente })

      if (not lugarOcupado) {
        ingrediente.ocupado(false)
        self.moverComida(ingrediente)
        self.quitar(ingrediente)
        cambio = ""
      }
    }

    const platoDestino = platos.find({ p => p.position() == ingrediente.position() })
    if ((platoDestino != null) and (ingrediente != platoDestino)) {
      platoDestino.agregarIngrediente(ingrediente)
      ingrediente.ocupado(false)
      self.moverComida(ingrediente)
      self.quitar(ingrediente)
      cambio = ""
      game.removeVisual(ingrediente)
      ingrediente.volver()
      game.addVisual(ingrediente)
    }

    platos.forEach({ p =>
      if (p.position() == cajon.position()) p.intentarAceptar()
      if (p.position() == tacho.position()) p.eliminarComida()
    })
  }
}}



const jugador1 = new Chef(nombre = 'chefOriginal' ,position = game.at(12, 3))
const jugador2 = new Chef(nombre = 'chefBarba' ,position = game.at(18, 3))

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

