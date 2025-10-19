class ScoreManager {
    var property puntos = 0

    method incrementar(cant) {
        self.puntos(self.puntos() + cant)
    }

    method obtener() {
        return self.puntos()
    }
}

const scoreManager = new ScoreManager()

object marcador {
    var property puntos = 0
    const property position = game.at(1, 1)

    method text() = "Score: " + puntos
    method textColor() = "000000FF"
    method fontSize() = 20

    method actualizar() {
        puntos = scoreManager.obtener()
    }
}
