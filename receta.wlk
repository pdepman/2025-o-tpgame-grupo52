import comida.*
class Receta {
    const ingredientes 

    method novacia(ingredientesDisponibles)=ingredientesDisponibles != null

    method contiene(ingredientesDisponibles)= ingredientesDisponibles.all{ingrediente=>ingredientes.contains(ingrediente)}

    method tieneRepetidos (ingredientesDisponibles)= ingredientesDisponibles.size() <= ingredientes.size()

    method mismaCantidad (ingredientesDisponibles)= ingredientesDisponibles.size() == ingredientes.size()
    
    method vaPorBuenCamino(ingredientesDisponibles)= self.contiene(ingredientesDisponibles) and self.tieneRepetidos(ingredientesDisponibles)

    method completa(ingredientesDisponibles)=self.contiene(ingredientesDisponibles) and self.mismaCantidad(ingredientesDisponibles)

}   



const hamburguesa_simple = new Receta(ingredientes=[pan, paty_cocinado])
const hamburguesa_completa = new Receta(ingredientes=[pan, paty_cocinado, lechuga_cortada, tomate])
const hamburguesa_huevo = new Receta(ingredientes=[pan, paty_cocinado, huevo_cocinado, lechuga_cortada])
const sandwich_bacon = new Receta(ingredientes=[pan, bacon_cocinado, lechuga_cortada, tomate])
const ensalada = new Receta(ingredientes=[lechuga_cortada, tomate])
const desayuno_bacon_huevo = new Receta(ingredientes=[huevo_cocinado, bacon_cocinado])

object sistemaDeRecetas {
  const todasLasRecetas = [
    hamburguesa_simple,
    hamburguesa_completa,
    hamburguesa_huevo,
    sandwich_bacon,
    ensalada,
    desayuno_bacon_huevo
  ]

  method recetasPosibles(ingredientesActuales) =
    todasLasRecetas.filter({ receta => receta.vaPorBuenCamino(ingredientesActuales) })
  
  method completita(ingredientesActuales) =
    todasLasRecetas.any({ receta => receta.completa(ingredientesActuales) })
  

}