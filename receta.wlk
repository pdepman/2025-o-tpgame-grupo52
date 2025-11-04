import comida.*
class Receta {

    const ingredientes 

    method novacia(ingredientesDisponibles)=ingredientesDisponibles != null

    method contiene(ingredientesDisponibles)= ingredientesDisponibles.all{ingrediente=>ingredientes.contains(ingrediente)}

    method tieneRepetidos (ingredientesDisponibles)= ingredientesDisponibles.size() <= ingredientes.size()

    method mismaCantidad (ingredientesDisponibles)= ingredientesDisponibles.size() == ingredientes.size()
    
    method vaPorBuenCamino(ingredientesDisponibles)= self.contiene(ingredientesDisponibles) and self.tieneRepetidos(ingredientesDisponibles)

    method completa(plato) = self.contiene(plato.ingredientes()) and self.mismaCantidad(plato.ingredientes())

    
}   



const hamburguesa_simple = new Receta(ingredientes=[pan, carne_cortada_cocinado])
const hamburguesa_completa = new Receta(ingredientes=[pan, carne_cortada_cocinado, lechuga_cortada, tomate])
const hamburguesa_huevo = new Receta(ingredientes=[pan, carne_cortada_cocinado, huevo_cocinado, lechuga_cortada])
const sandwich_bacon = new Receta(ingredientes=[pan, puerco_cortada_cocinado, lechuga_cortada, tomate])
const ensalada = new Receta(ingredientes=[lechuga_cortada, tomate])
const desayuno_bacon_huevo = new Receta(ingredientes=[huevo_cocinado, puerco_cortada_cocinado])

object sistemaDeRecetas {
  const todasLasRecetas = [hamburguesa_simple,hamburguesa_completa,hamburguesa_huevo,sandwich_bacon,ensalada,desayuno_bacon_huevo]
  
  method recetasPosibles(ingredientesActuales) =
    todasLasRecetas.filter({ receta => receta.vaPorBuenCamino(ingredientesActuales) })
  
  method completita(plato) =
    todasLasRecetas.any({ receta => receta.completa(plato) })
  

}