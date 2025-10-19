import wollok.game.*
import score.*

object temporizador {
    const PUNTUACION_MINIMA = 20  // Puntos necesarios para ganar
    
    method iniciar() {
        console.println("🎮 ===========================")
        console.println("⏰ TEMPORIZADOR INICIADO")
        console.println("🕑 Tiempo: 2:00 minutos") 
        console.println("🏆 Meta: " + PUNTUACION_MINIMA + " puntos para ganar")
        console.println("🎮 ===========================")
        
        // Programar mensajes de cuenta regresiva
        self.programarMensajes()
        
        game.schedule(120000, {
            self.finalizarJuego()
        })
    }
    
    method programarMensajes() {
        // Mensajes de progreso del tiempo
        game.schedule(60000, { console.println("⏰ 1:00 - 1 minuto restante") })
        game.schedule(90000, { console.println("⏰ 0:30 - 30 segundos restantes") })
        game.schedule(100000, { console.println("⏰ 0:20 - 20 segundos") })
        game.schedule(110000, { console.println("⏰ 0:10 - ¡ÚLTIMOS SEGUNDOS!") })
        game.schedule(114000, { console.println("⏰ 0:06 - 6 segundos!") })
        game.schedule(115000, { console.println("⏰ 0:05 - 5 segundos!") })
        game.schedule(116000, { console.println("⏰ 0:04 - 4 segundos!") })
        game.schedule(117000, { console.println("⏰ 0:03 - 3 segundos!") })
        game.schedule(118000, { console.println("⏰ 0:02 - 2 segundos!") })
        game.schedule(119000, { console.println("⏰ 0:01 - 1 segundo!") })
    }
    
    method finalizarJuego() {
        var puntosFinales = scoreManager.puntos()
        
        // Determinar si ganó o perdió
        if (puntosFinales >= PUNTUACION_MINIMA) {
            self.mostrarVictoria(puntosFinales)
        } else {
            self.mostrarDerrota(puntosFinales)
        }
        
        self.deshabilitarControles()
    }
    
    method mostrarVictoria(puntos) {
        var mensajeVictoria = object {
            var property position = game.at(6, 6)  // Posición centrada
            method image() = "you_win.jpg"  // Tu imagen de victoria
        }
        game.addVisual(mensajeVictoria)
        
        console.println("🎉 ===========================")
        console.println("🏆 ¡VICTORIA!")
        console.println("⭐ Puntos alcanzados: " + puntos)
        console.println("🎯 Meta superada: " + PUNTUACION_MINIMA + " puntos")
        console.println("🎉 ===========================")
    }
    
    method mostrarDerrota(puntos) {
        var mensajeDerrota = object {
            var property position = game.at(6, 6)  // Misma posición centrada
            method image() = "you_lose.jpg"  // Tu imagen de derrota
        }
        game.addVisual(mensajeDerrota)
        
        console.println("💀 ===========================")
        console.println("😞 ¡DERROTA!")
        console.println("⭐ Puntos obtenidos: " + puntos)
        console.println("🎯 Meta requerida: " + PUNTUACION_MINIMA + " puntos")
        console.println("📉 Faltaron: " + (PUNTUACION_MINIMA - puntos) + " puntos")
        console.println("💀 ===========================")
    }
    
    method deshabilitarControles() {
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