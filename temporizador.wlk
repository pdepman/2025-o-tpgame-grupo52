import wollok.game.*
import score.*

object temporizadorVisual {
    var property position = game.at(1, 14)
    var miTiempo = "03:00"

    method text() = "⏰ " + miTiempo
    method textColor() = "FF0000FF"
    method fontSize() = 50

    method cambiarTiempo(nuevoTiempo) {
        miTiempo = nuevoTiempo
    }
}


object temporizador {
    var duracion = 120        // Tiempo total (2 minutos)
    var tiempoRestante = 120
    var tiempoInicio = 0
    var enEjecucion = false
      // Para cancelar schedules anteriores

    // ========================
    // 🔵 INICIAR TEMPORIZADOR
    // ========================
    method iniciar() {
        if (!enEjecucion) {
            tiempoInicio = game.currentTime()
            enEjecucion = true
            self.actualizar()
        }
    }

    // ======================
    // 🟡 PAUSAR TEMPORIZADOR
    // ======================
    method pausar() {
        enEjecucion = false
    }

    // =======================
    // 🔴 REINICIAR TEMPORIZADOR
    // =======================
    method reiniciar() {
        enEjecucion = false
        tiempoRestante = duracion
        temporizadorVisual.cambiarTiempo("03:00")
        
    }

    // ===================
    // ♻ ACTUALIZAR CONTADOR
    // ===================
    method actualizar() {
        if (enEjecucion){
        var ahora = game.currentTime()
        var transcurrido = (ahora - tiempoInicio) / 1000
        var segundos = transcurrido.floor()

        tiempoRestante = duracion - segundos

        if (tiempoRestante > 0) {
            self.actualizarVisual()
            game.schedule(100, { self.actualizar() })
        } else {
            tiempoRestante = 0
            self.actualizarVisual()
            self.finalizarJuego()
        }}
    }

    // ===========================
    // ⏱ ACTUALIZAR VISUAL DEL TEXTO
    // ===========================
    method actualizarVisual() {
        var min = (tiempoRestante / 60).floor()
        var seg = tiempoRestante % 60
        var segTxt = if (seg < 10) "0" + seg.toString() else seg.toString()
        temporizadorVisual.cambiarTiempo(min.toString() + ":" + segTxt)
    }

    // ======================
    // 🟥 FINALIZAR JUEGO
    // ======================
    method finalizarJuego() {
        self.pausar()
        console.println("🎯 ¡TIEMPO AGOTADO!")

        if (marcador1.puntos() > marcador2.puntos()) {
            self.mostrarVictoria1()
        } else if (marcador1.puntos() < marcador2.puntos()) {
            self.mostrarVictoria2()
        } else {
            self.mostrarEmpate()
        }
    }

    // ======================
    // 🏆 MENSAJES FINALES
    // ======================
    method mostrarVictoria1() {
        var m = object { var property position = game.at(4,1); method image() = "chef1gano.png" }
        game.addVisual(m)
    }

    method mostrarVictoria2() {
        var m = object { var property position = game.at(4,1); method image() = "chef2gano.png" }
        game.addVisual(m)
    }

    method mostrarEmpate() {
        var m = object { var property position = game.at(4,1); method image() = "chefEmpate.png" }
        game.addVisual(m)
    }
}