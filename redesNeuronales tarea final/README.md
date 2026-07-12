
# Perceptrón para la compuerta XOR con ingeniería de características

---

## Integrantes

- **Gabriel Ernesto González Palomo** — Matrícula: `190468`
- **Carlos Rafael Mendez Gonzalez** — Matrícula: `191209`
- **Rosendo Maximiliano Rodriguez Alvarado** — Matrícula: `190254`

## Datos académicos

- **Materia:** Programación avanzada
- **Profesor:** Jesus Alejandro Flores Hernandez


## Descripción

Este proyecto aplica un **perceptrón simple** a las salidas de la compuerta lógica XOR.

La compuerta XOR no puede resolverse directamente con un perceptrón utilizando solamente las entradas originales \(x_1\) y \(x_2\), porque sus clases no son linealmente separables en dos dimensiones.

Para solucionar el problema se utiliza **ingeniería de características**, agregando el término de interacción:

\[
x_3 = x_1x_2
\]

De esta forma, cada entrada se transforma mediante el siguiente mapa polinomial:

\[
\phi(x_1,x_2) = (x_1,x_2,x_1x_2)
\]

La transformación lleva los datos a un espacio tridimensional en el que sí es posible encontrar un plano de separación.

---

## Objetivo

Implementar y entrenar un perceptrón que clasifique correctamente las cuatro combinaciones de la compuerta XOR después de aplicar una transformación polinomial de grado 2.

---

## Tabla de verdad de XOR

| \(x_1\) | \(x_2\) | Salida XOR |
|:---:|:---:|:---:|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

En el espacio original, los puntos de las clases 0 y 1 se encuentran en posiciones diagonales, por lo que no existe una sola recta capaz de separarlos correctamente.

---

## Ingeniería de características

Se agrega una tercera característica:

\[
x_3 = x_1x_2
\]

Los datos transformados quedan de la siguiente manera:

| Entrada original | Entrada transformada | Salida |
|:---:|:---:|:---:|
| \((0,0)\) | \((0,0,0)\) | 0 |
| \((0,1)\) | \((0,1,0)\) | 1 |
| \((1,0)\) | \((1,0,0)\) | 1 |
| \((1,1)\) | \((1,1,1)\) | 0 |

Esta transformación corresponde a un **mapeo polinomial de grado 2**, ya que incorpora el producto entre las variables de entrada.

---

## Modelo del perceptrón

El perceptrón calcula una puntuación mediante:

\[
s = w_1x_1 + w_2x_2 + w_3x_3 + b
\]

Para el entrenamiento, las clases originales se convierten de:

\[
\{0,1\} \rightarrow \{-1,+1\}
\]

La regla de actualización utilizada es:

\[
w_i \leftarrow w_i + \eta yx_i
\]

\[
b \leftarrow b + \eta y
\]

donde:

- \(w_i\) representa cada peso;
- \(b\) es el sesgo;
- \(\eta\) es la tasa de aprendizaje;
- \(y\) es la clase esperada;
- \(x_i\) es una característica de entrada.

---

## Resultados del entrenamiento

El perceptrón converge después de **12 épocas** y obtiene los siguientes parámetros:

```text
w1 = 2
w2 = 2
w3 = -5
b  = -1
```

El plano de decisión resultante es:

\[
2x_1 + 2x_2 - 5x_3 - 1 = 0
\]

Este plano separa correctamente las dos clases en el espacio tridimensional.

### Verificación

| Entrada | Transformación | Esperado | Obtenido | Puntuación |
|:---:|:---:|:---:|:---:|:---:|
| \((0,0)\) | \((0,0,0)\) | 0 | 0 | -1 |
| \((0,1)\) | \((0,1,0)\) | 1 | 1 | 1 |
| \((1,0)\) | \((1,0,0)\) | 1 | 1 | 1 |
| \((1,1)\) | \((1,1,1)\) | 0 | 0 | -2 |

La exactitud obtenida es:

\[
\frac{4}{4} \times 100 = 100\%
\]

---

## Estructura del proyecto

```text
.
├── README.md
├── Perceptron_XOR_Gabriel_Carlos_Rosendo.js
├── Presentacion_Perceptron_XOR.pdf
└── Presentacion_Perceptron_XOR.pptx
```

- `Perceptron_XOR_Gabriel_Carlos_Rosendo.js`: implementación y entrenamiento del perceptrón.
- `Presentacion_Perceptron_XOR.pdf`: presentación final de la actividad.
- `Presentacion_Perceptron_XOR.pptx`: versión editable de la presentación.
- `README.md`: documentación del proyecto.

---

## Requisitos

Para ejecutar el código se necesita:

- [Node.js](https://nodejs.org/) instalado.
- Una terminal o consola de comandos.

Puede comprobarse la instalación con:

```bash
node --version
```

---

## Ejecución

1. Clonar el repositorio:

```bash
git clone URL_DEL_REPOSITORIO
```

2. Entrar en la carpeta del proyecto:

```bash
cd NOMBRE_DEL_REPOSITORIO
```

3. Ejecutar el programa:

```bash
node Perceptron_XOR_Gabriel_Carlos_Rosendo.js
```

---

## Salida esperada

El programa muestra:

- la transformación aplicada;
- el número de épocas necesarias para converger;
- los pesos y el sesgo obtenidos;
- el plano de separación;
- las actualizaciones realizadas en cada época;
- la clasificación de las cuatro entradas;
- la exactitud final.

Ejemplo resumido:

```text
Transformación: phi(x1, x2) = (x1, x2, x1*x2)
Épocas hasta converger: 12
Pesos: w1=2, w2=2, w3=-5
Sesgo: b=-1
Plano: 2x1 + 2x2 - 5x3 - 1 = 0
Exactitud: 4/4 = 100%
```

---

## Gráfica en GeoGebra 3D

Para representar los puntos transformados en GeoGebra 3D pueden introducirse:

```text
A = (0,0,0)
B = (0,1,0)
C = (1,0,0)
D = (1,1,1)
```

El plano de separación se grafica con:

```text
2x + 2y - 5z - 1 = 0
```

Los puntos `A` y `D` pertenecen a la clase 0, mientras que `B` y `C` pertenecen a la clase 1.

---

## Conclusión

Un perceptrón simple no puede resolver directamente la compuerta XOR en el espacio bidimensional, porque sus datos no son linealmente separables.

Al agregar la característica \(x_3=x_1x_2\), los datos se representan en tres dimensiones y se vuelven linealmente separables mediante un plano. El perceptrón logra clasificar correctamente todas las combinaciones y alcanza una exactitud del 100 %.

