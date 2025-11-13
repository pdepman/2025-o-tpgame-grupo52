import hitbox.*
import chef.*
import comida.*
import elementosDeCocina.*
import score.*
import temporizador.*
import spawn.*
import teclasYposiciones.*

object masterChefGame{
    method iniciar (){
    game.title("Chef")
	game.height(16)
	game.width(24)
	game.cellSize(40) 


    game.boardGround("fondo_test5.png")

	temporizador.iniciar()
	

	game.addVisual(jugador1)
	game.addVisual(jugador2)
	game.addVisual(cajon1)
	game.addVisual(cajon2)
 
	game.addVisual(generadorPan)
	game.addVisual(generadorCarne)
	game.addVisual(generadorLechuga)
	game.addVisual(generadorHuevo)
	game.addVisual(generadorPuerco)
	game.addVisual(generadorTomate)
	game.addVisual(plato3)
	game.addVisual(plato4)
	game.addVisual(plato1)
	game.addVisual(plato2)
	game.addVisual(tacho1)
	game.addVisual(tacho2)
	game.addVisual(tabla1)
	game.addVisual(tabla2)
	game.addVisual(tabla3)
	game.addVisual(tabla4)
	game.addVisual(marcador1)
	game.addVisual(marcador2)


		
    configTeclas.iniciar()
    }
}