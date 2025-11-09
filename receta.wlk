import comida.*
class Receta {

    const ingredientes 



    method contiene(ingredientesDisponibles) =
    ingredientesDisponibles.all { ingrediente =>
        ingredientes.any { otro => otro.nombre() == ingrediente.nombre() }
    }


    method mismaCantidad (ingredientesDisponibles)= ingredientesDisponibles.size() == ingredientes.size()
    
    method todoComible(ingredientesDisponibles)= ingredientesDisponibles.all{ingrediente=>ingrediente.ingredienteListo()}

    method completa(plato) = self.contiene(plato.ingredientes()) and self.mismaCantidad(plato.ingredientes())and self.todoComible(plato.ingredientes())



    
}   



const hamburguesa_completa = new Receta(ingredientes=[pan, carne, lechuga, tomate])
const sandwich_bacon = new Receta(ingredientes=[pan, puerco, lechuga, tomate])
const ensalada = new Receta(ingredientes=[lechuga, tomate])
const bacon_huevo = new Receta(ingredientes=[huevo, puerco])

object sistemaDeRecetas {
  const todasLasRecetas = [hamburguesa_completa,sandwich_bacon,ensalada,bacon_huevo]
  
  method recetasPosibles(ingredientesActuales) =
    todasLasRecetas.filter({ receta => receta.vaPorBuenCamino(ingredientesActuales) })
  
  method completita(plato) =
    todasLasRecetas.any({ receta => receta.completa(plato) })
  

}