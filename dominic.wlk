object dominic {
  const property autos = []

  method comprarAuto_(nuevoAuto) {
    autos.add(nuevoAuto)
  }

  method autosQueEstanEnCondiciones() = autos.filter({auto => auto.estaListoParaCorrer()})

  method autosQueNoEstanEnCondiciones() = autos.filter({auto => not auto.estaListoParaCorrer()})

  method mandarAutosAlTaller() {
    taller.agregarAutosAReparar(self.autosQueNoEstanEnCondiciones())
  }

  method hacerPruebaDeVelocidad() {
    autos.forEach({auto => auto.pruebaDeVelocidad()})
  }

  method venderTodosLosAutos() {
    autos.clear()
  }

  method promedioDeVelocidadMaxima() = autos.sum({auto => auto.velocidadMaxima()}) / autos.size()

  method autoMasRapidoEnFuncionamiento() = self.autosQueEstanEnCondiciones().max({auto => auto.velocidadMaxima()})

  method hayUnAutoDelDobleDeVelocidad() = self.autoMasRapidoEnFuncionamiento().velocidadMaxima() > self.promedioDeVelocidadMaxima() * 2
}

object taller {
  const property autosAReparar = []

  method agregarAutoAReparar(autoAAgregar) {
    autosAReparar.add(autoAAgregar)
  }

  method agregarAutosAReparar(autosAAgregar) {
    autosAReparar.addAll(autosAAgregar)
  }

  method repararAutos() {
    autosAReparar.forEach({auto => auto.reparar()})
    autosAReparar.forEach({auto => if(auto.estaListoParaCorrer()) autosAReparar.remove(auto)})
  }
}

//Autos
object laFerrari {
  var funcionalidadDelMotor = 87

  method estaListoParaCorrer() = funcionalidadDelMotor >= 65

  method reparar() {
    funcionalidadDelMotor = 100
  }

  method pruebaDeVelocidad() {
    funcionalidadDelMotor = 0.max(funcionalidadDelMotor - 30) 
  } 

  method velocidadMaxima() = 110 + if(funcionalidadDelMotor > 75) 15 else 0
}

object laFlechaRubi {
  var property combustible = 100

  var tipoCombustible = gasolina

  var color = azul

  method reparar() {
    self.combustible(combustible * 2)
    color = color.cambiarDeColor()
  }

  method estaListoParaCorrer() = tipoCombustible.nivelMinimo() < combustible and color.esBuenoParaCorrer()

  method pruebaDeVelocidad() {
    self.combustible(combustible - 5)
  }

  method velocidadBase() = combustible * 2

  method velocidadMaxima() = self.velocidadBase() + tipoCombustible.velocidadAgregada(self.velocidadBase())

  method cambiarColor() {
    color = color.cambiarDeColor()
  }

  method cambiarCombustible(nuevoCombustible) {
    tipoCombustible = nuevoCombustible
  }
}

object elIntocable {
  var estaListoParaCorrer = true 

  method reparar() {
    estaListoParaCorrer = true
  }

  method pruebaDeVelocidad() {
    estaListoParaCorrer = false
  }

  method velocidadMaxima() = 45

  method estaListoParaCorrer() = estaListoParaCorrer
}

object alambiqueVeloz {
  var ultimaCiudad = buenosAires
  
  var nivelDeCombustible = 100 

  method reparar() {
    nivelDeCombustible = nivelDeCombustible + ultimaCiudad.cargaEstandarDeCombustible()
  }

  method estaListoParaCorrer() = nivelDeCombustible > 0

  method pruebaDeVelocidad() {
    nivelDeCombustible = 0.max(nivelDeCombustible - 10)
    ultimaCiudad = ultimaCiudad.siguienteDestino()
  }

  method velocidadMaxima() = if (self.estaListoParaCorrer()) ultimaCiudad.velocidadMaxima() + nivelDeCombustible / 10 else 0
}

//Combustibles
object gasolina  {
  method nivelMinimo() = 85

  method velocidadAgregada(valorDeCombustible) = 10
}

object nafta  {
  method nivelMinimo() = 50

  method velocidadAgregada(valorDeCombustible) = valorDeCombustible / 10
}

object nitrogenoLiquido  {
  method nivelMinimo() = 0

  method velocidadAgregada(valorDeCombustible) = valorDeCombustible * 10
}

//Colores
object azul  {
  method cambiarDeColor() = verde

  method esBuenoParaCorrer() = false
}

object rojo  {
  method cambiarDeColor() = azul

  method esBuenoParaCorrer() = true
}

object verde  {
  method cambiarDeColor() = rojo

  method esBuenoParaCorrer() = false
}

//Lugares
object buenosAires {
  method velocidadMaxima() = 60

  method cargaEstandarDeCombustible() = 100

  method siguienteDestino() = paris
}

object bagdad {
  method velocidadMaxima() = 150

  method cargaEstandarDeCombustible() = 200

  method siguienteDestino() = buenosAires
}

object paris {
  method velocidadMaxima() = 40

  method cargaEstandarDeCombustible() = 50

  method siguienteDestino() = bagdad
}