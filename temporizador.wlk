import wollok.game.*
import score.*

object temporizador {
    method iniciar() {
        console.println("🎮 ===========================")
        console.println("⏰ TEMPORIZADOR INICIADO")
        console.println("🕑 Tiempo: 2:00 minutos")
        console.println("🎮 ===========================")
        
        // Programar mensajes de progreso
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
        
        // Programar Game Over después de 2 minutos (120000 ms)
        game.schedule(120000, {
            var pantallaGameOver = object {
                var property position = game.at(6, 2)
                method image() = "game_over.jpg"
            }
            game.addVisual(pantallaGameOver)
            
            console.println("💀 ===========================")
            console.println("🎯 ¡GAME OVER!")
            console.println("⏰ Tiempo agotado")
            console.println("🏆 Puntuación final: " + scoreManager.puntos())
            console.println("💀 ===========================")
            
            self.deshabilitarControles()
        })
    }
    
    method deshabilitarControles() {
        // Deshabilitar todos los controles de teclado
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