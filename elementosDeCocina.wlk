import comida.*
import receta.*
import score.*
import chef.*


class ContenedorDeIngredientes {
    var property position = game.center()
    method puedeMoverA(destino) = destino == self.position()
}

// class Cajon inherits ContenedorDeIngredientes {
//     method image() = 'cajon.png'

// }
class Cajon inherits ContenedorDeIngredientes{

  method image() = "cajon.png"

  method interactuarCon(chef) {
    const platoEncima = platos.find({ p => p.position() == self.position() })

    if (platoEncima != null and sistemaDeRecetas.completita(platoEncima)) {
      platoEncima.intentarAceptar() 
    }
    
       
    
  }
}

const cajon = new Cajon(position = game.at(10,10))

class Tacho inherits ContenedorDeIngredientes {
    method image() = 'tacho.png'
    method interactuarCon(chef) {
    self.borrar()
  }
  method borrar(){}
}

const tacho = new Tacho(position = game.at(10,5))

class Plato {    
    const ingredientes  = []
    var property position = posicionOriginal
    const property posicionOriginal 
    var estaEnInventario = false 
    var ocupado = false 

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

    method image() = "plato"+self.cantidad()+".png" 

 
  method agregarIngrediente(i) = ingredientes.add(i)

    method ingredientes() = ingredientes

    method intentarAceptar() {
        if (sistemaDeRecetas.completita(self)){
            marcador.actualizar()
            self.volver()
            ingredientes.clear()
        } 
    }

    method eliminarComida(){
        ingredientes.clear()
        self.volver()
    }

    method volver(){
        position = posicionOriginal
    }
}
class Horno {
  var property position = game.center()
  method image() = 'horno.png'
  
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
class Tabla {
  var property position = game.center()
  method image() = 'tabla.png'
  
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
const tabla =new Tabla(position = game.at(12,9))

const horno = new Horno()
object cocina {
  const comidas = [plato1, plato2]

  method registrarComida(unaComida) {
    comidas.add(unaComida)
  }

  method comidas() = comidas
}
const plato1 = new Plato(posicionOriginal= game.at(12, 11))
const plato2 = new Plato(posicionOriginal = game.at(19, 11))




