# Punto 7: Resumen de los documentos

## Documentos revisados

1. `0-ingenieria-del-conocimiento.pdf`
2. `C-sistemasExpertosBasadosEnReglas.pdf`

## 1. Ingeniería del conocimiento

La **ingeniería del conocimiento** es una rama de la inteligencia artificial dedicada a obtener, organizar, representar y utilizar el conocimiento necesario para construir sistemas capaces de resolver problemas especializados. Su objetivo no es almacenar datos sin estructura, sino convertir la experiencia de una persona experta en una forma que una computadora pueda interpretar y aplicar.

### Conocimiento y sus tipos

El conocimiento combina información con procedimientos que permiten interpretarla y actuar. Puede distinguirse en tres grupos principales:

- **Conocimiento declarativo:** describe hechos, objetos y relaciones. Responde a preguntas como “qué es” o “qué se sabe”.
- **Conocimiento procedural:** explica cómo realizar una actividad o resolver un problema. Suele expresarse mediante procedimientos o reglas.
- **Metaconocimiento:** es conocimiento sobre el propio conocimiento, por ejemplo, saber qué regla conviene utilizar primero o qué información es más confiable.

### Participantes principales

La construcción de un sistema experto requiere colaboración entre diferentes personas:

- El **experto humano** domina el área del problema y aporta ejemplos, reglas prácticas, excepciones y criterios adquiridos mediante la experiencia.
- El **ingeniero del conocimiento** entrevista al experto, organiza la información, selecciona una representación adecuada y la implementa dentro del sistema.
- El **usuario final** utiliza el sistema y proporciona casos reales que ayudan a comprobar su utilidad.

### Adquisición del conocimiento

La adquisición consiste en extraer información relevante de especialistas, documentos, bases de datos y casos anteriores. Es una de las etapas más difíciles porque una parte de la experiencia de los expertos es tácita: la aplican de manera automática, aunque no siempre puedan explicarla con facilidad.

El proceso suele incluir:

1. Identificación del problema y delimitación del dominio.
2. Reconocimiento de conceptos, variables y relaciones importantes.
3. Formalización del conocimiento mediante reglas, estructuras lógicas o modelos.
4. Implementación de una base de conocimientos.
5. Pruebas, validación y corrección con ayuda del experto.

### Formas de representación

Para que una computadora procese el conocimiento, este debe representarse formalmente. Entre los métodos comunes se encuentran:

- Lógica proposicional y lógica de predicados.
- Reglas de producción.
- Redes semánticas.
- Marcos o *frames*.
- Árboles de decisión.
- Gráficos conceptuales.

La elección depende del problema. Las reglas son útiles cuando el razonamiento puede expresarse mediante condiciones; las redes semánticas permiten representar relaciones; los árboles son apropiados para decisiones jerárquicas.

### Métodos para adquirir conocimiento

Los métodos pueden clasificarse como:

- **Manuales:** entrevistas, observación, cuestionarios y análisis de protocolos.
- **Semiautomatizados:** herramientas que ayudan al experto o al ingeniero a organizar conceptos y reglas.
- **Automatizados:** técnicas de aprendizaje automático que generan patrones o reglas a partir de datos.

En conclusión, la ingeniería del conocimiento transforma experiencia humana dispersa en una estructura verificable, reutilizable y comprensible para un sistema informático.

---

## 2. Sistemas expertos basados en reglas

Los **sistemas expertos basados en reglas** representan el conocimiento mediante expresiones del tipo:

```text
SI se cumple una condición
ENTONCES se obtiene una conclusión o se ejecuta una acción.
```

Este enfoque resulta conveniente cuando el dominio posee criterios relativamente claros, por ejemplo, diagnóstico técnico, clasificación de casos, evaluación académica o selección de procedimientos.

### Componentes

#### Base de conocimientos

Contiene las reglas generales del dominio. Es la parte relativamente estable del sistema, ya que representa criterios y relaciones que pueden aplicarse a distintos casos.

#### Memoria de trabajo

Almacena los hechos de la situación actual. A diferencia de la base de conocimientos, cambia cada vez que se analiza un caso nuevo. También puede guardar conclusiones intermedias obtenidas por el motor de inferencia.

#### Motor de inferencia

Es el componente encargado de comparar los hechos con las condiciones de las reglas, decidir cuáles pueden ejecutarse y añadir nuevas conclusiones a la memoria de trabajo.

### Reglas simples y compuestas

Una regla simple utiliza una condición y una conclusión. Las reglas compuestas combinan varias condiciones mediante operadores como **Y**, **O** y **NO**.

Ejemplo:

```text
SI el alumno tiene promedio menor que 70
Y tiene dos o más materias reprobadas
ENTONCES el alumno se encuentra en riesgo académico.
```

La sustitución y simplificación de reglas permiten reducir expresiones complejas y evitar duplicaciones dentro de la base de conocimientos.

### Mecanismos lógicos

- **Modus ponens:** si se conoce que `A implica B` y se confirma `A`, puede concluirse `B`. Es la base del razonamiento hacia adelante.
- **Modus tollens:** si `A implica B` y se demuestra que `B` es falso, puede concluirse que `A` también es falso.
- **Resolución:** combina expresiones lógicas para eliminar términos y obtener nuevas conclusiones.

### Encadenamiento hacia adelante

Parte de los hechos disponibles. El motor busca reglas cuyas premisas sean verdaderas, las ejecuta y agrega sus conclusiones como hechos nuevos. El proceso continúa hasta que ya no puedan activarse reglas o se alcance una conclusión relevante.

Es útil cuando se reciben muchos datos y se desea descubrir todas las consecuencias posibles.

### Encadenamiento hacia atrás

Parte de una meta o hipótesis. El sistema localiza reglas capaces de producir esa conclusión y después intenta comprobar sus premisas. El proceso continúa hasta encontrar hechos conocidos o hasta determinar que la meta no puede demostrarse.

Es apropiado en consultas concretas, como determinar si una persona cumple los requisitos para recibir un diagnóstico o una recomendación.

### Coherencia y resolución de conflictos

Una base de conocimientos debe evitar reglas contradictorias. Cuando varias reglas pueden ejecutarse al mismo tiempo, el sistema necesita una estrategia para elegir, por ejemplo:

- Prioridad asignada por el diseñador.
- Regla más específica.
- Regla que utiliza hechos más recientes.
- Orden de aparición.

La memoria de trabajo también debe revisarse para impedir hechos incompatibles que produzcan conclusiones absurdas.

### Explicación de resultados

Una ventaja importante de los sistemas expertos es la posibilidad de justificar sus conclusiones. El módulo de explicación puede mostrar:

- Qué hechos fueron proporcionados por el usuario.
- Qué reglas se activaron.
- Qué conclusiones intermedias se produjeron.
- Por qué se aceptó o rechazó una hipótesis.

Esta trazabilidad aumenta la confianza y facilita detectar errores en la base de conocimientos.

### Incertidumbre

Los sistemas basados únicamente en lógica clásica trabajan con valores verdaderos o falsos. Sin embargo, muchos problemas reales contienen información incompleta o incierta. Para atenderlos pueden incorporarse factores de certeza, probabilidades, lógica difusa o modelos bayesianos.

## Conclusión general

La ingeniería del conocimiento proporciona el proceso para capturar y organizar la experiencia de especialistas. Los sistemas expertos basados en reglas aplican ese conocimiento mediante una base de reglas, una memoria de hechos y un motor de inferencia. Su utilidad depende de que el dominio esté bien delimitado, las reglas sean coherentes y el sistema pueda explicar cómo llegó a cada resultado.
