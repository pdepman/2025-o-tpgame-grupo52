import hitbox.*
import wollok.game.*
import elementosDeCocina.*
import spawn.*
import teclasYposiciones.*

class Chef {
  var cambio = ""
  const nombre
  var sostiene = null
  var property orientacion = derecha
  var property position = game.origin()
  var sufijo = "Default"
  
  method direccionObjeto() = orientacion.desplazamiento()
  
  method inventarioVacio() = sostiene == null
  
  method image() = ((nombre + sufijo) + cambio) + ".png"
  
  method mover(desplazamiento) {
    var nueva = game.at(
      position.x() + desplazamiento.x(),
      position.y() + desplazamiento.y()
    )
    if ((not pared.todopuedeMoverA(nueva)) and (not self.hayColisionEn(nueva)))
      self.position(nueva)
  }
  
  method moverComida(ingrediente) {
    if (!self.inventarioVacio()) {
      var posChefActual = self.position()
      var direccion = null
      
      direccion = self.direccionObjeto()
      
      ingrediente.position(
        posChefActual.x() + direccion.x(),
        posChefActual.y() + direccion.y()
      )
    }
  }
  
  method hayColisionEn(destino) = chefs.any(
    { chef => chef.position() == destino }
  )
  
  method intentarMover(direccion) {
    if (orientacion == direccion) {
      if (direccion.puedeMover(self)) direccion.mover(self)
    }
    sufijo = direccion.sufijo()
    orientacion = direccion
    self.moverComida(sostiene)
  }
  
  method posicionAdelante() {
    var pos = self.position()
    if (orientacion == derecha) {
      return pos.right(1)
    }
    if (orientacion == izquierda) {
      return pos.left(1)
    }
    if (orientacion == arriba) {
      return pos.up(1)
    }
    if (orientacion == abajo) {
      return pos.down(1)
    }
    return pos
  }
  
  method intentarInteraccion() {
    const posAdelante = self.posicionAdelante()
    const objetoCercano = objetosInteractivos.find(
      { o => o.position() == posAdelante }
    )
    
    if (objetoCercano != null) objetoCercano.interactuarCon(self)
  }
  
  method ingredienteCercano() {
    var posicionAdelante = self.posicionAdelante()
    
    return cocina.comidas().find({ c => c.position() == posicionAdelante })
  }
  
  method intentarGenerar() {
    const posAdelante = self.posicionAdelante()
    const generadorCercano = generadores.find(
      { g => g.position() == posAdelante }
    )
    
    if (generadorCercano != null) generadorCercano.generar()
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
    if (self.inventarioVacio()) self.intentarTomarIngrediente()
    else self.intentarSoltarIngrediente()
  }
  
  method intentarTomarIngrediente() {
    const ingredienteCercano = self.ingredienteCercano()
    if ((ingredienteCercano != null) and (not ingredienteCercano.ocupado()))
      self.agarrarIngrediente(ingredienteCercano)
  }
  
  method agarrarIngrediente(ingrediente) {
    ingrediente.estaEnInventario(true)
    ingrediente.ocupado(true)
    self.llevar(ingrediente)
    cambio = "_agarro"
  }
  
  method intentarSoltarIngrediente() {
    const ingrediente = sostiene
    
    if (sostiene == self.ingredienteCercano()) self.intentarDejarEnSuLugar(
        ingrediente
      )
    
    const platoDestino = self.encontrarPlatoDestino(ingrediente)
    if (platoDestino != null) self.colocarIngredienteEnPlato(
        ingrediente,
        platoDestino
      )
    
    self.verificarCajonYTacho()
  }
  
  method intentarDejarEnSuLugar(ingrediente) {
    const lugarOcupado = cocina.comidas().any(
      { i => (i.position() == ingrediente.position()) and (i != ingrediente) }
    )
    
    if (not lugarOcupado) {
      ingrediente.ocupado(false)
      self.moverComida(ingrediente)
      self.quitar(ingrediente)
      cambio = ""
    }
  }
  
  method encontrarPlatoDestino(ingrediente) = platos.find(
    { p => p.position() == ingrediente.position() }
  )
  
  method colocarIngredienteEnPlato(ingrediente, platoDestino) {
    if (ingrediente != platoDestino) {
      platoDestino.agregarIngrediente(ingrediente)
      ingrediente.ocupado(false)
      self.moverComida(ingrediente)
      self.quitar(ingrediente)
      cambio = ""
      game.removeVisual(ingrediente)
      ingrediente.volver()
      game.addVisual(ingrediente)
    }
  }
  
  method verificarCajonYTacho() {
    platos.forEach(
      { p =>
        if (p.position() == cajon.position()) p.intentarAceptar()
        if (p.position() == tacho.position()) p.eliminarComida()
      }
    )
  }
}

const jugador1 = new Chef(nombre = "chefOriginal", position = game.at(12, 3))

const jugador2 = new Chef(nombre = "chefBarba", position = game.at(18, 3))