import comida.*
import receta.*
import score.*
import chef.*
import spawn.*
import hitbox.*



class ContenedorDeIngredientes {
    var property position = game.center()
    method puedeMoverA(destino) = destino == self.position()

  method initialize() {
    pared.registrarbloque(self)
  }
  method iniciar() {
    game.addVisual(self)
  }
}


class Cajon inherits ContenedorDeIngredientes{

    method intentarAceptar(chef,plato) {
        if (sistemaDeRecetas.completita(plato) and (sistemaPedidos.estaElPedido(sistemaDeRecetas.queCOSA(plato)))){
           chef.actualizar(plato) 
           sistemaPedidos.completarPedido(sistemaDeRecetas.queCOSA(plato))
            plato.volver()
            plato.ingredientes().clear()
            plato.ensuciar()
        } 
    }

}



const cajon1 = new Cajon(position = game.at(11,11))
const cajon2 = new Cajon(position = game.at(12,11))

class Tacho inherits ContenedorDeIngredientes {
    method image() = 'tacho.png'

    
    method eliminarComida(plato){
        plato.ingredientes().clear()
        plato.volver()
        plato.ensuciar()
    }


}

const tacho1 = new Tacho(position = game.at(5 ,2))

const tacho2 = new Tacho(position = game.at(18,2))

class Plato {    
    const ingredientes  = []
    var property sucio = false
    var property position = posicionOriginal
    const property posicionOriginal 
    var estaEnInventario = false 
    var ocupado = false 
    const property esPlato = true
  
  
  method iniciar() {
    game.addVisual(self)
  }


  method estaSucio() = sucio
  method ensuciar(){ sucio = true }
  method limpiar() { sucio = false }

     method initialize() {
    cocina.registrarPlato(self)
  }

    method ocupado() = ocupado
  
  method ocupado(parametro) {
    ocupado = parametro 
  } 
    
    method estaEnInventario() = estaEnInventario
    method estaEnInventario(parametro) {
        estaEnInventario = parametro 
    } 

    method position(newPosX, newPosY){
        position = game.at(newPosX,newPosY)  
    }

    method cantidad()=ingredientes.size()

method image() {
  if(self.estaSucio()){
     return "plato_sucio.png"
  }else if(ingredientes.isEmpty()){
    return "plato.png"
  }else if (sistemaDeRecetas.completita(self)) {
    return "plato_" + sistemaDeRecetas.queCOSA(self).nombre() + ".png"
  } else if (not ingredientes.isEmpty() and self.todoComible()and not self.tieneRepetidos(ingredientes)) {
    const nombresIngredientes = ingredientes.map({ i => i.nombre() })
    return "plato_" + nombresIngredientes.join("_") + ".png"
  } else {
    return "plato_caca.png"
  }
}

 method todoComible()= self.ingredientes().all{ingrediente=>ingrediente.ingredienteListo()}

 
  method agregarIngrediente(i) = ingredientes.add(i)

    method ingredientes() = ingredientes

    method volver(){
        position = posicionOriginal
    }

    method tieneRepetidos(lista) {
  return lista.size() != lista.asSet().size()
}
}
class Horno {
  var property position = game.center()
  method image() = 'horno.png'

  method initialize() {
    cocina.registrarobjetosInteractivos(self)
  }
    method iniciar() {
    game.addVisual(self)
  }

  
  
  const comidasCocinables = ['puerco_cortada', 'huevo', 'carne_cortada']
  
  method esCocinable(comida) = comidasCocinables.any({ c => c == comida.apodo() })

  method hornear(comida) {
    comida.cambiarNombre(comida.apodo() + "_cocinado")
    comida.cambiarImagen(comida.apodo() + "_cocinado.png")
    comida.faltaCocinar(false)
  }

  method estaArriba(comida) = comida.position() == self.position()
  

  method interactuarCon(chef) {
    const comidaEncima = cocina.comidas().find({ c => self.estaArriba(c) and self.esCocinable(c) })
    
    if (comidaEncima != null) {
      self.hornear(comidaEncima)
    }
  }
}
class Lavavajilla {
  var property position = game.center()
  method image() = 'lavavajilla.png'

  method initialize() {
    cocina.registrarobjetosInteractivos(self)
  }
    method iniciar() {
    game.addVisual(self)
  }

  method puedeLavar(plato) = plato.estaSucio()


  method estaArriba(plato) = plato.position() == self.position()

  method lavar(plato) {
    plato.limpiar()
  }

  method interactuarCon(chef) {
    const platoEncima = cocina.platos().find({ p => self.estaArriba(p) and self.puedeLavar(p) })

    if (platoEncima != null) {
      self.lavar(platoEncima)
    } 
  }
}

const lavavajilla1 = new Lavavajilla(position=game.at(4,9))
const lavavajilla2 = new Lavavajilla(position=game.at(4,8))
const lavavajilla3 = new Lavavajilla(position=game.at(19,9))
const lavavajilla4 = new Lavavajilla(position=game.at(19,8))

class Tabla {
  var property position = game.center()
  method image() = 'tabla.png'

    method initialize() {
    cocina.registrarobjetosInteractivos(self)
  }
    method iniciar() {
    game.addVisual(self)
  }

  
  const comidasCortables = ['lechuga','puerco','carne']
  
  method esCocinable(comida) = comidasCortables.any({ c => c == comida.apodo() })

  method cortar(comida) {
    comida.cambiarNombre(comida.apodo() + "_cortada")
    comida.cambiarImagen(comida.apodo() + "_cortada.png")
    comida.faltaCortar(false)
  }

  method estaArriba(comida) = comida.position() == self.position()
  

  method interactuarCon(chef) {
    const comidaEncima = cocina.comidas().find({ c => self.estaArriba(c) and self.esCocinable(c) })
    
    if (comidaEncima != null) {
      self.cortar(comidaEncima)
    }
  }
}
const tabla1 =new Tabla(position = game.at(4,5))
const tabla2 =new Tabla(position = game.at(4,4))
const tabla3 =new Tabla(position = game.at(19,4))
const tabla4 =new Tabla(position = game.at(19,5))

const horno1 = new Horno(position = game.at(9,11))
const horno2 = new Horno(position = game.at(7,11))
const horno3 = new Horno(position = game.at(14,11))
const horno4 = new Horno(position = game.at(16,11))
object cocina {
  const platos = []
  const  property cajones = [cajon1,cajon2]
  const property tachos = [tacho1,tacho2]
  const comidas = [plato1,plato2,plato3,plato4]
  const objetosInteractivos=[]


  method registrarobjetosInteractivos(objetoInteractivo) {
    objetosInteractivos.add(objetoInteractivo)
}
 method registrartachos(tacho) {
    tachos.add(tacho)
}
 method registrarcajones(cajon) {
    cajones.add(cajon)
}

  method registrarComida(unaComida) {
    comidas.add(unaComida)
  }
  method registrarPlato(plato) {
    platos.add(plato)
  }
  method cajones() = cajones
  method tachos() = tachos

  method platos() = platos
  method comidas() = comidas
  method objetosInteractivos() = objetosInteractivos
}
const plato1 = new Plato(posicionOriginal= game.at(10, 7))
const plato2 = new Plato(posicionOriginal= game.at(10, 5))
const plato3 = new Plato(posicionOriginal= game.at(13, 7))
const plato4 = new Plato(posicionOriginal= game.at(13, 5))





