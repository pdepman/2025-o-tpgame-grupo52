import comida.*
class Receta {

    const ingredientes 
    const property nombre 
    const property puntos



    method contiene(ingredientesDisponibles) =
    ingredientesDisponibles.all { ingrediente =>
        ingredientes.any { otro => otro.nombre() == ingrediente.nombre() }
    }


    method mismaCantidad (ingredientesDisponibles)= ingredientesDisponibles.size() == ingredientes.size()
    

    method completa(plato) = self.contiene(plato.ingredientes()) and self.mismaCantidad(plato.ingredientes())and plato.todoComible()

}   



const hamburguesa_completa = new Receta(ingredientes=[pan, carne, lechuga, tomate],nombre='hamburguesa',puntos=50)
const sandwich_bacon = new Receta(ingredientes=[pan, puerco, lechuga, tomate],nombre='sandwich_bacon',puntos=50)
const ensalada = new Receta(ingredientes=[lechuga, tomate],nombre='ensalada',puntos=20)
const bacon_huevo = new Receta(ingredientes=[huevo, puerco],nombre='huevo_bacon',puntos=30)

object sistemaDeRecetas {
  const todasLasRecetas = [hamburguesa_completa,sandwich_bacon,ensalada,bacon_huevo]
  
  method recetasPosibles(ingredientesActuales) =
    todasLasRecetas.filter({ receta => receta.vaPorBuenCamino(ingredientesActuales) })
  
  method completita(plato) =
    todasLasRecetas.any({ receta => receta.completa(plato) })

  
  method queCOSA(plato) =
    todasLasRecetas.find({ receta => receta.completa(plato) })



}