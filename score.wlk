object marcador {
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
