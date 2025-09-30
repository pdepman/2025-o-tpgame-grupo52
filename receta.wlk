import comida.*
 class receta{
     const ingredientes 

    method estaCompleta(ingredientesDisponibles) {
        if (ingredientes == ingredientesDisponibles) {
            return true
        } else {
            return false
        }
    }
 }

const hamburguesa_simple = new receta(ingredientes=[pan, paty_cocinado])
const hamburguesa_completa = new receta(ingredientes=[pan, paty_cocinado, lechuga_cortada, tomate])
const hamburguesa_huevo = new receta(ingredientes=[pan, paty_cocinado, huevo_cocinado, lechuga_cortada])
const sandwich_bacon = new receta(ingredientes=[pan, bacon_cocinado, lechuga_cortada, tomate])
const ensalada = new receta(ingredientes=[lechuga_cortada, tomate])
const desayuno_bacon_huevo = new receta(ingredientes=[huevo_cocinado, bacon_cocinado])

