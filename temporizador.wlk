import wollok.game.*
import score.*
import menu.*

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
    const duracion = 180        // Tiempo total (2 minutos)
    var tiempoRestante = 180
    var tiempoInicio = 0
    var enEjecucion = false
    var  modo = versus 
      // Para cancelar schedules anteriores
    method modo(nuevoModo){
        modo = nuevoModo
    }

  method quitar() {
    game.removeVisual(self)
  }
    // ========================
    // 🔵 INICIAR TEMPORIZADOR
    // ========================
    method iniciar() {
        if (!enEjecucion) {
            game.addVisual(temporizadorVisual)
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
    tiempoInicio = game.currentTime()
    enEjecucion = true               

    temporizadorVisual.cambiarTiempo("03:00")  

    self.actualizar()        
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
            if(modo== versus){
            self.finalizarJuego()}
            else  self.finalizarJuego1()
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

    var property mensajeFinal = null

    method finalizarJuego1(){
        console.println("🎯 ¡TIEMPO AGOTADO!")

        if (marcador.puntos() >=500) {
            self.mostrarVictoria3()
        } else  self.mostrarDerrota()
        }

    

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
    mensajeFinal = object { 
        var property position = game.at(4,1)
        method image() = "chef1gano.png"
    }
    game.addVisual(mensajeFinal)
}

method mostrarVictoria2() {
    mensajeFinal = object { 
        var property position = game.at(4,1)
        method image() = "chef2gano.png"
    }
    game.addVisual(mensajeFinal)
}

method mostrarEmpate() {
    mensajeFinal = object { 
        var property position = game.at(4,1)
        method image() = "chefEmpate.png"
    }
    game.addVisual(mensajeFinal)
}
method mostrarVictoria3() {
    mensajeFinal = object { 
        var property position = game.at(4,1)
        method image() = "chefsgano.png"
    }
    game.addVisual(mensajeFinal)
}

method mostrarDerrota() {
    mensajeFinal = object { 
        var property position = game.at(4,1)
        method image() = "chefsperdio.png"
    }
    game.addVisual(mensajeFinal)
}

method borrarMensajeFinal() {
    if(mensajeFinal != null) {
        game.removeVisual(mensajeFinal)
        mensajeFinal = null
    }
}


}