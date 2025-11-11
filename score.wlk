import chef.*
class Marcador{
    const chef 
    var property puntos = 0
    const property position = game.at(1, 1)

    method incrementar(cant) {
        puntos = puntos + cant
    }

    method obtener() = puntos

    method actualizar() {
        self.incrementar(10)
    }

  
    method text() = "Score: " + puntos
    method textColor() = "000000FF"
    method fontSize() = 20
}

const marcador1 = new Marcador(position = game.at(1, 1),chef = jugador1)

const marcador2 = new Marcador(position = game.at(20, 1),chef = jugador2)