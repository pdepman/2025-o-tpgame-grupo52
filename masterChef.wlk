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


    game.boardGround("fondo_test4.png")

	temporizador.iniciar()
	

	game.addVisual(jugador1)
	game.addVisual(jugador2)
	game.addVisual(horno)
	game.addVisual(tabla)
	game.addVisual(duro)	
	game.addVisual(cajon)
	game.addVisual(tomate)	
	game.addVisual(lechuga)	
	game.addVisual(duro2)
	game.addVisual(generadorPan)
	game.addVisual(generadorCarne)
	game.addVisual(generadorLechuga)
	game.addVisual(generadorHuevo)
	game.addVisual(generadorPuerco)
	game.addVisual(generadorTomate)
	game.addVisual(puerco_cortada1)
	game.addVisual(plato1)
	game.addVisual(plato2)
	game.addVisual(marcador)
	game.addVisual(tacho)
		
    configTeclas.iniciar()
    }
}