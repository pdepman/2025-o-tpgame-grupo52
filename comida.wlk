object filete {
  var position = game.at(5,2)
  const nombre = 'filete'

  method image() = 'carne_cruda.png'

  method position() = position

  method position(nuevaPosition) {
    position = nuevaPosition
  }

  method nombre() = nombre
}
