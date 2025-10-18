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