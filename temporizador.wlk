import wollok.game.*
import score.*

object temporizadorVisual {
    var property position = game.at(1, 14)
    var miTiempo = "02:00"
    
    method text() = "⏰ " + miTiempo
    method textColor() = "FF0000FF"
    method fontSize() = 40
    
    method cambiarTiempo(nuevoTiempo) {
        miTiempo = nuevoTiempo
    }
}

object temporizador {
    const puntuacionMinima = 100
    var tiempoRestante = 120
    var tiempoInicio = 0
    var enEjecucion = true
    
    method iniciar() {
        tiempoInicio = game.currentTime()
        game.addVisual(temporizadorVisual)
        console.println("⏰ TEMPORIZADOR INICIADO - 2 minutos")
        self.actualizar()
    }
    
    method actualizar() {
        if (enEjecucion) {
            var tiempoActual = game.currentTime()
            var tiempoTranscurrido = tiempoActual - tiempoInicio
            var segundosTranscurridos = (tiempoTranscurrido / 1000).floor()
            
            tiempoRestante = 120 - segundosTranscurridos
            
            if (tiempoRestante > 0) {
                self.actualizarVisual()
                game.schedule(100, { self.actualizar() })
            } else {
                tiempoRestante = 0
                self.actualizarVisual()
                self.finalizarJuego()
            }
        }
    }
    
    method actualizarVisual() {
        var minutos = (tiempoRestante / 60).floor()
        var segundos = tiempoRestante % 60
        var segundosTexto = ""
        
        // CORREGIDO: if con retorno en todos los flujos
        if (segundos < 10) {
            segundosTexto = "0" + segundos.toString()
        } else {
            segundosTexto = segundos.toString()
        }
        
        var tiempoFormateado = minutos.toString() + ":" + segundosTexto
        temporizadorVisual.cambiarTiempo(tiempoFormateado)
        
        // console.println("Tiempo: " + tiempoFormateado)
    }
    
    method finalizarJuego() {
        enEjecucion = false
        console.println("🎯 ¡TIEMPO AGOTADO!")
        
        var puntosFinales = marcador.puntos()
        console.println("Puntos finales: " + puntosFinales)
        
        if (puntosFinales >= puntuacionMinima) {
            self.mostrarVictoria(puntosFinales)
        } else {
            self.mostrarDerrota(puntosFinales)
        }
        
        self.deshabilitarControles()
    }
    
    method mostrarVictoria(puntos) {
        console.println("🏆 ¡VICTORIA!")
        var mensaje = object {
            var property position = game.at(6, 1)
            method image() = "you_win.jpg"
        }
        game.addVisual(mensaje)
    }
    
    method mostrarDerrota(puntos) {
        console.println("💀 DERROTA")
        var mensaje = object {
            var property position = game.at(6, 6)
            method image() = "you_lose.jpg"
        }
        game.addVisual(mensaje)
    }
    
    method deshabilitarControles() {
        console.println("Controles deshabilitados")
        keyboard.a().onPressDo({ })
        keyboard.d().onPressDo({ })
        keyboard.w().onPressDo({ })
        keyboard.s().onPressDo({ })
        keyboard.e().onPressDo({ })
        keyboard.left().onPressDo({ })
        keyboard.right().onPressDo({ })
        keyboard.up().onPressDo({ })
        keyboard.down().onPressDo({ })
        keyboard.enter().onPressDo({ })
    }
}