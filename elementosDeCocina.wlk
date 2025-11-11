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
}

class Cajon inherits ContenedorDeIngredientes{

 
}

const cajon1 = new Cajon(position = game.at(11,11))
const cajon2 = new Cajon(position = game.at(12,11))


class Tacho inherits ContenedorDeIngredientes {
    method image() = 'tacho.png'
}

const tacho1 = new Tacho(position = game.at(5 ,2))

const tacho2 = new Tacho(position = game.at(18,2))

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

    method intentarAceptar(chef) {
        if (sistemaDeRecetas.completita(self)){
           chef.actualizar()
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
const tabla1 =new Tabla(position = game.at(4,5))
const tabla2 =new Tabla(position = game.at(4,4))
const tabla3 =new Tabla(position = game.at(19,4))
const tabla4 =new Tabla(position = game.at(19,5))

const horno1 = new Horno(position = game.at(9,11))
const horno2 = new Horno(position = game.at(7,11))
const horno3 = new Horno(position = game.at(14,11))
const horno4 = new Horno(position = game.at(16,11))
object cocina {
  const comidas = [plato1, plato2]

  method registrarComida(unaComida) {
    comidas.add(unaComida)
  }

  method comidas() = comidas
}
const plato1 = new Plato(posicionOriginal= game.at(12, 11))
const plato2 = new Plato(posicionOriginal = game.at(19, 11))


const objetosInteractivos=[generadorPan,generadorCarne,generadorLechuga,generadorHuevo,generadorPuerco,generadorTomate,horno1,horno2,horno3,horno4,tabla1,tabla2,tabla3,tabla4]


const platos = [plato1, plato2]