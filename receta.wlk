import comida.*
class Receta {
    const ingredientes 

    method estaCompleta(ingredientesDisponibles) {
        if (ingredientesDisponibles == null) return false
        if (ingredientesDisponibles.size() != ingredientes.size()) return false

        return ingredientes.all({ ing =>
            var encontrado = false
            ingredientesDisponibles.forEach({ disp =>
                if (ing == disp) {
                    encontrado = true
                }
            })
            return encontrado
        })
    }
}



const hamburguesa_simple = new Receta(ingredientes=[pan, paty_cocinado])
const hamburguesa_completa = new Receta(ingredientes=[pan, paty_cocinado, lechuga_cortada, tomate])
const hamburguesa_huevo = new Receta(ingredientes=[pan, paty_cocinado, huevo_cocinado, lechuga_cortada])
const sandwich_bacon = new Receta(ingredientes=[pan, bacon_cocinado, lechuga_cortada, tomate])
const ensalada = new Receta(ingredientes=[lechuga_cortada, tomate])
const desayuno_bacon_huevo = new Receta(ingredientes=[huevo_cocinado, bacon_cocinado])


