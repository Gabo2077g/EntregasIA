/**
 * Perceptrón para clasificar la compuerta XOR mediante
 * ingeniería de características.
 *
 * Ejecución:
 *   node perceptron_xor.js
 */

const datos = [
  { entrada: [0, 0], esperado: 0 },
  { entrada: [0, 1], esperado: 1 },
  { entrada: [1, 0], esperado: 1 },
  { entrada: [1, 1], esperado: 0 },
];

/**
 * Mapeo polinomial explícito de grado 2.
 * Se agrega el término de interacción x1*x2.
 */
function transformar([x1, x2]) {
  return [x1, x2, x1 * x2];
}

/** Convierte las clases XOR {0, 1} a {-1, +1}. */
function convertirClase(salida) {
  return salida === 1 ? 1 : -1;
}

class Perceptron {
  constructor(numeroCaracteristicas, tasaAprendizaje = 1) {
    this.pesos = Array(numeroCaracteristicas).fill(0);
    this.sesgo = 0;
    this.tasaAprendizaje = tasaAprendizaje;
    this.historial = [];
  }

  calcularPuntuacion(caracteristicas) {
    return this.pesos.reduce(
      (suma, peso, indice) => suma + peso * caracteristicas[indice],
      this.sesgo,
    );
  }

  predecirSigno(caracteristicas) {
    const puntuacion = this.calcularPuntuacion(caracteristicas);
    return puntuacion >= 0 ? 1 : -1;
  }

  predecirXOR(entrada) {
    const caracteristicas = transformar(entrada);
    return this.predecirSigno(caracteristicas) === 1 ? 1 : 0;
  }

  entrenar(muestras, maximoEpocas = 100) {
    for (let epoca = 1; epoca <= maximoEpocas; epoca += 1) {
      let actualizaciones = 0;

      for (const muestra of muestras) {
        const x = transformar(muestra.entrada);
        const y = convertirClase(muestra.esperado);
        const puntuacion = this.calcularPuntuacion(x);

        // Si el punto está mal clasificado o justo en la frontera,
        // se actualizan pesos y sesgo.
        if (y * puntuacion <= 0) {
          for (let i = 0; i < this.pesos.length; i += 1) {
            this.pesos[i] += this.tasaAprendizaje * y * x[i];
          }
          this.sesgo += this.tasaAprendizaje * y;
          actualizaciones += 1;
        }
      }

      this.historial.push({ epoca, actualizaciones });

      if (actualizaciones === 0) {
        return epoca;
      }
    }

    throw new Error(
      `El perceptrón no convergió después de ${maximoEpocas} épocas.`,
    );
  }
}

function imprimirResultados(modelo, epocas) {
  const [w1, w2, w3] = modelo.pesos;

  console.log("\nPERCEPTRÓN PARA XOR CON INGENIERÍA DE CARACTERÍSTICAS");
  console.log("====================================================");
  console.log("Transformación: phi(x1, x2) = (x1, x2, x1*x2)");
  console.log(`Épocas hasta converger: ${epocas}`);
  console.log(`Pesos: w1=${w1}, w2=${w2}, w3=${w3}`);
  console.log(`Sesgo: b=${modelo.sesgo}`);
  console.log(
    `Plano: ${w1}x1 + ${w2}x2 ${w3 < 0 ? "-" : "+"} ${Math.abs(w3)}x3 ${modelo.sesgo < 0 ? "-" : "+"} ${Math.abs(modelo.sesgo)} = 0`,
  );

  console.log("\nÉpoca | Actualizaciones");
  for (const registro of modelo.historial) {
    console.log(
      `${String(registro.epoca).padStart(5)} | ${registro.actualizaciones}`,
    );
  }

  console.log("\nEntrada | Transformada | Esperado | Obtenido | Puntuación");
  console.log("-----------------------------------------------------------");

  let aciertos = 0;
  for (const muestra of datos) {
    const transformada = transformar(muestra.entrada);
    const obtenido = modelo.predecirXOR(muestra.entrada);
    const puntuacion = modelo.calcularPuntuacion(transformada);
    const correcto = obtenido === muestra.esperado;
    if (correcto) aciertos += 1;

    console.log(
      `${JSON.stringify(muestra.entrada).padEnd(7)} | ` +
        `${JSON.stringify(transformada).padEnd(12)} | ` +
        `${String(muestra.esperado).padStart(8)} | ` +
        `${String(obtenido).padStart(8)} | ` +
        `${String(puntuacion).padStart(10)} ${correcto ? "✓" : "✗"}`,
    );
  }

  console.log(`\nExactitud: ${aciertos}/${datos.length} = ${(aciertos / datos.length) * 100}%`);
}

function main() {
  const perceptron = new Perceptron(3, 1);
  const epocas = perceptron.entrenar(datos, 100);
  imprimirResultados(perceptron, epocas);
}

main();
