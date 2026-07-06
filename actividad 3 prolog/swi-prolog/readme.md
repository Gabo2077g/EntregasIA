
## Integrantes
- Nombre: Gabriel Ernesto González Palomo
- Matrícula: 190468
- Nombre: Rosendo Maximiliano Rodríguez Alvarado
- Matrícula: 190254
- Nombre: Carlos Rafael Mendez Gonzalez
- Matrícula: 191209

## Materia
Programación Avanzada 

## Profesor
Jesus Alejandro Flores Hernandez

# Sistema Experto ISC en SWI-Prolog

Sistema experto desarrollado en **SWI-Prolog** para apoyar a alumnos, tutores o gestores académicos en la elección de cursos del programa educativo de Ingeniería en Sistemas Computacionales.

El sistema utiliza una base de conocimiento con alumnos, materias, seriaciones e historial académico. A partir de estos datos, aplica reglas lógicas para recomendar materias, validar seriación, detectar alumnos de alto rendimiento, revisar bajas académicas y calcular posibles aspirantes para abrir cursos.

## Objetivo

Crear un sistema experto que ayude en la toma de decisiones académicas, respetando:

- Seriación de materias.
- Promedio general del alumno.
- Cantidad de materias reprobadas.
- Historial de intentos por materia.
- Reglas de baja académica.
- Identificación de alumnos de alto rendimiento.
- Consulta de materias por semestre y área.
- Cantidad de aspirantes para abrir un curso.

## Tecnologías utilizadas

- SWI-Prolog
- Servidor HTTP de SWI-Prolog
- Respuestas en formato JSON

## Requisitos

Tener instalado **SWI-Prolog**.

Para verificar la instalación desde Git Bash:

```bash
swipl --version
```

Si el comando no funciona en Windows, se puede usar la ruta completa:

```bash
"/c/Program Files/swipl/bin/swipl.exe" --version
```

## Estructura principal del sistema

El sistema contiene:

### Base de conocimiento

- `alumno/3`: registra alumnos.
- `materia/5`: registra materias, semestre, área y créditos.
- `requisito/2`: define la seriación entre materias.
- `historial/4`: guarda los intentos y calificaciones del alumno.

### Reglas expertas

- `aprobada/2`: verifica si un alumno aprobó una materia.
- `puede_cursar/2`: determina si un alumno puede cursar una materia.
- `carga_maxima/2`: calcula la carga máxima permitida.
- `baja_alumno/1`: indica si el alumno debe ser dado de baja.
- `alto_rendimiento/1`: identifica alumnos con promedio mayor o igual a 90.
- `recomendar_materias/2`: recomienda materias disponibles.
- `aspirantes_materia/2`: calcula aspirantes para abrir un curso.

## Ejecución del proyecto

Guardar el archivo principal como:

```bash
sistema_isc.pl
```

Abrir Git Bash en la carpeta donde está el archivo y ejecutar:

```bash
swipl sistema_isc.pl
```

Si SWI-Prolog no está agregado al PATH, usar:

```bash
"/c/Program Files/swipl/bin/swipl.exe" sistema_isc.pl
```

Si el servidor inicia correctamente, aparecerá un mensaje como:

```bash
Servidor iniciado en http://localhost:8080
Presiona Ctrl+C para detenerlo.
```

Mientras esa terminal permanezca abierta, el servidor seguirá funcionando.

## Endpoints disponibles

### Obtener todas las materias

```text
http://localhost:8080/materias
```

Muestra todas las materias registradas en el sistema.

---

### Obtener materias por semestre

```text
http://localhost:8080/materias_semestre?semestre=1
```

Ejemplo:

```text
http://localhost:8080/materias_semestre?semestre=2
```

Devuelve las materias correspondientes al semestre indicado.

---

### Obtener materias por área

```text
http://localhost:8080/materias_area?area=programacion
```

Ejemplo:

```text
http://localhost:8080/materias_area?area=matematicas
```

Devuelve las materias que pertenecen al área indicada.

---

### Consultar información de un alumno

```text
http://localhost:8080/alumno?id=a001
```

Muestra información general del alumno, incluyendo:

- Nombre.
- Programa.
- Promedio general.
- Reprobadas vigentes.
- Carga máxima.
- Estado académico.

---

### Consultar historial completo de un alumno

```text
http://localhost:8080/alumno_historial?id=a002
```

Muestra las materias cursadas por el alumno, cuántas veces las cursó y las calificaciones obtenidas.

---

### Consultar historial de una materia específica

```text
http://localhost:8080/alumno_historial?id=a002&materia=matematicas1
```

Muestra los intentos y calificaciones de un alumno en una materia específica.

---

### Verificar si un alumno debe ser dado de baja

```text
http://localhost:8080/alumno_baja?id=a003
```

Indica si el alumno debe ser dado de baja por haber reprobado tres veces una materia.

---

### Consultar materias candidatas para un alumno

```text
http://localhost:8080/alumno_candidatas?id=a004
```

Muestra las materias que el alumno puede cursar respetando la seriación.

---

### Recomendar carga académica para un alumno

```text
http://localhost:8080/alumno_recomendar?id=a002
```

Recomienda materias para el alumno tomando en cuenta:

- Seriación.
- Promedio general.
- Reprobadas vigentes.
- Carga máxima permitida.

---

### Consultar alumnos de alto rendimiento

```text
http://localhost:8080/alumnos_alto_rendimiento
```

Muestra los alumnos con promedio general mayor o igual a 90.

---

### Consultar posibles aspirantes para abrir un curso

```text
http://localhost:8080/curso_aspirantes?materia=matematicas2
```

Devuelve cuántos alumnos podrían cursar una materia específica.

## Ejemplos con curl

También se pueden probar los endpoints desde Git Bash usando `curl`.

```bash
curl "http://localhost:8080/materias"
```

```bash
curl "http://localhost:8080/alumno?id=a001"
```

```bash
curl "http://localhost:8080/alumno_recomendar?id=a002"
```

```bash
curl "http://localhost:8080/alumno_baja?id=a003"
```

```bash
curl "http://localhost:8080/curso_aspirantes?materia=matematicas2"
```

## Reglas académicas implementadas

### Seriación

Un alumno no puede cursar una materia si no ha aprobado sus requisitos.

Ejemplo:

```prolog
requisito(matematicas2, matematicas1).
```

Esto significa que el alumno no puede cursar `matematicas2` si no aprobó `matematicas1`.

### Carga máxima

El sistema limita la cantidad de materias que puede cargar un alumno.

- Si el promedio general es menor que 80, la carga máxima es de 4 materias.
- Si el alumno tiene más de una materia reprobada vigente, la carga máxima es de 4 materias.
- Si el alumno debe ser dado de baja, la carga máxima es 0.
- Si no tiene restricciones, puede cargar hasta 6 materias.

### Baja académica

Un alumno debe ser dado de baja si reprobó tres veces una misma materia.

### Alto rendimiento

Un alumno es considerado de alto rendimiento si su promedio general es mayor o igual a 90.

## Datos de ejemplo

El sistema incluye alumnos de prueba como:

- `a001`
- `a002`
- `a003`
- `a004`
- `a005`

Y materias de ejemplo como:

- `matematicas1`
- `matematicas2`
- `fundamentos_programacion`
- `programacion_orientada_objetos`
- `base_datos`
- `inteligencia_artificial`
- `sistemas_expertos`

Estos datos pueden modificarse para adaptarse a la retícula real del programa educativo de ISC.

## Cómo detener el servidor

En la terminal donde se está ejecutando el servidor, presionar:

```bash
Ctrl + C
```

Después seleccionar la opción correspondiente para abortar o detener el proceso.


## Licencia

Este proyecto es de uso académico.