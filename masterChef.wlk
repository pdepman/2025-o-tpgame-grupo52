import receta.*
import hitbox.*
import chef.*
import comida.*
import elementosDeCocina.*
import score.*
import temporizador.*
import spawn.*
import teclasYposiciones.*
import menu.*

object masterChefGame{
    method iniciar (){
    game.title("Chef")
	game.height(16)
	game.width(24)
	game.cellSize(40) 

    game.boardGround("fondo1.png")
    configTeclas.iniciar()
    menu.iniciar()


    }
}
