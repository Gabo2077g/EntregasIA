## Autores

- Nombre: Gabriel Ernesto González Palomo
- Matrícula: 190468
- Nombre: Rosendo Maximiliano Rodríguez Alvarado
- Matrícula: 190254
- Nombre: Carlos Rafael Mendez Gonzalez
- Matrícula: 191209,   
Profesor: Jesus Alejandro Flores Hernandez    
Lenguaje utilizado: Tau-Prolog con JavaScript

# Sistema Experto para Asignación de Proyectos de Software

Este proyecto es un sistema experto desarrollado con **Tau-Prolog**, **HTML**, **CSS** y **JavaScript**.  
Su objetivo es llevar el control de los proyectos de software que pueden asignarse a un grupo de programadores de acuerdo con su nivel.

El sistema permite consultar desarrolladores, consultar proyectos, verificar si existe personal suficiente para un proyecto y saber qué tipo de personal hace falta contratar.

## Descripción del problema

Se tiene un grupo de programadores con diferentes niveles de experiencia:

- Junior
- Avanzado
- Senior

También se tienen proyectos de software con diferentes niveles de dificultad:

- Bajo
- Medio
- Alto
- Muy alto

Cada proyecto requiere una cantidad diferente de personal según su nivel de dificultad.

## Reglas de asignación

| Nivel del proyecto | Personal requerido |
|---|---|
| Bajo | 1 desarrollador avanzado y 1 desarrollador junior |
| Medio | 1 desarrollador senior y 1 desarrollador avanzado |
| Alto | 1 desarrollador senior, 1 desarrollador avanzado y 1 desarrollador junior |
| Muy alto | 1 desarrollador senior, 2 desarrolladores avanzados y 2 desarrolladores junior |

## Funcionalidades del sistema

El sistema experto permite realizar las siguientes consultas:

1. Mostrar la lista de desarrolladores con sus niveles.
2. Mostrar la lista de proyectos con sus niveles.
3. Verificar si para un proyecto dado se tiene el personal necesario.
4. Mostrar qué personal hace falta contratar para un proyecto dado.
5. Sugerir una posible asignación de desarrolladores para un proyecto.

## Tecnologías utilizadas

- HTML
- CSS
- JavaScript
- Tau-Prolog

## Base de conocimientos

La base de conocimientos contiene 10 desarrolladores ficticios con diferentes niveles.

```prolog
desarrollador(ana, junior).
desarrollador(luis, junior).
desarrollador(sofia, junior).
desarrollador(carlos, junior).
desarrollador(maria, junior).
desarrollador(pedro, avanzado).
desarrollador(laura, senior).
desarrollador(diego, senior).
desarrollador(elena, senior).
desarrollador(ricardo, senior).
```

También contiene 10 proyectos ficticios con diferentes niveles.

```prolog
proyecto(proyecto_a, bajo).
proyecto(proyecto_b, bajo).
proyecto(proyecto_c, medio).
proyecto(proyecto_d, medio).
proyecto(proyecto_e, alto).
proyecto(proyecto_f, alto).
proyecto(proyecto_g, muy_alto).
proyecto(proyecto_h, muy_alto).
proyecto(proyecto_i, medio).
proyecto(proyecto_j, bajo).
```

## Requerimientos de los proyectos

Los requerimientos se representan mediante hechos en Prolog.

```prolog
requerimiento(bajo, avanzado, 1).
requerimiento(bajo, junior, 1).

requerimiento(medio, senior, 1).
requerimiento(medio, avanzado, 1).

requerimiento(alto, senior, 1).
requerimiento(alto, avanzado, 1).
requerimiento(alto, junior, 1).

requerimiento(muy_alto, senior, 1).
requerimiento(muy_alto, avanzado, 2).
requerimiento(muy_alto, junior, 2).
```

## Reglas principales del sistema experto

El sistema cuenta con reglas que permiten contar el personal disponible, comparar los requerimientos de cada proyecto y determinar si se tiene suficiente personal.

### Contar desarrolladores por nivel

```prolog
cantidad_disponible(Nivel, Cantidad) :-
    personal_por_nivel(Nivel, Lista),
    contar_lista(Lista, Cantidad).
```

Esta regla permite saber cuántos desarrolladores existen de un nivel determinado.

### Verificar si hay personal suficiente

```prolog
personal_suficiente(Proyecto) :-
    proyecto(Proyecto, NivelProyecto),
    \+ (
        requerimiento(NivelProyecto, NivelProgramador, CantidadRequerida),
        cantidad_disponible(NivelProgramador, CantidadDisponible),
        CantidadDisponible < CantidadRequerida
    ).
```

Esta regla verifica si el personal disponible cumple con los requerimientos del proyecto.

### Saber qué personal falta contratar

```prolog
falta_contratar(Proyecto, NivelProgramador, Faltan) :-
    requeridos_por_proyecto(Proyecto, NivelProgramador, CantidadRequerida),
    cantidad_disponible(NivelProgramador, CantidadDisponible),
    CantidadRequerida > CantidadDisponible,
    Faltan is CantidadRequerida - CantidadDisponible.
```

Esta regla indica qué nivel de programador hace falta contratar y cuántos se necesitan.

## Consultas disponibles

### Listar desarrolladores

```prolog
desarrollador(Nombre, Nivel).
```

Muestra todos los desarrolladores registrados y su nivel correspondiente.

### Listar proyectos

```prolog
proyecto(Proyecto, Nivel).
```

Muestra todos los proyectos registrados y su nivel de dificultad.

### Verificar personal suficiente para un proyecto

```prolog
personal_suficiente(proyecto_a).
```

Permite saber si existe suficiente personal para realizar un proyecto específico.

### Consultar personal faltante

```prolog
falta_contratar(proyecto_g, Nivel, Cantidad).
```

Indica qué tipo de desarrollador hace falta contratar y cuántos se necesitan.

### Sugerir asignación de personal

```prolog
asignacion_proyecto(proyecto_a, Seniors, Avanzados, Juniors).
```

Sugiere una posible asignación de desarrolladores disponibles para un proyecto.

## Cómo ejecutar el proyecto

1. Descargar o clonar el repositorio.

```bash
git clone URL_DEL_REPOSITORIO
```

2. Abrir la carpeta del proyecto.

```bash
cd sistema-experto-proyectos-tau-prolog
```

3. Abrir el archivo `index.html` en un navegador web.

No es necesario instalar dependencias adicionales, ya que Tau-Prolog se carga mediante CDN.

## Estructura del proyecto

```txt
sistema-experto-proyectos-tau-prolog/
│
├── index.html
└── README.md
```

## Ejemplos de uso

### Ejemplo 1: listar desarrolladores

Al presionar el botón **Listar desarrolladores**, el sistema muestra la lista de programadores registrados.

```txt
Lista de desarrolladores con sus niveles:

Nombre = ana, Nivel = junior
Nombre = luis, Nivel = junior
Nombre = sofia, Nivel = junior
Nombre = carlos, Nivel = junior
Nombre = maria, Nivel = junior
Nombre = pedro, Nivel = avanzado
Nombre = laura, Nivel = senior
Nombre = diego, Nivel = senior
Nombre = elena, Nivel = senior
Nombre = ricardo, Nivel = senior
```

### Ejemplo 2: listar proyectos

Al presionar el botón **Listar proyectos**, el sistema muestra la lista de proyectos registrados.

```txt
Lista de proyectos con sus niveles:

Proyecto = proyecto_a, Nivel = bajo
Proyecto = proyecto_b, Nivel = bajo
Proyecto = proyecto_c, Nivel = medio
Proyecto = proyecto_d, Nivel = medio
Proyecto = proyecto_e, Nivel = alto
Proyecto = proyecto_f, Nivel = alto
Proyecto = proyecto_g, Nivel = muy_alto
Proyecto = proyecto_h, Nivel = muy_alto
Proyecto = proyecto_i, Nivel = medio
Proyecto = proyecto_j, Nivel = bajo
```

### Ejemplo 3: verificar si hay personal suficiente

Para un proyecto de nivel bajo, como `proyecto_a`, el sistema puede indicar que sí existe personal suficiente.

```txt
Sí hay personal suficiente para proyecto_a.
```

Esto ocurre porque un proyecto de nivel bajo requiere:

```txt
1 desarrollador avanzado
1 desarrollador junior
```

y la base de conocimientos cuenta con esos perfiles.

### Ejemplo 4: consultar personal faltante

Para un proyecto de nivel muy alto, como `proyecto_g`, el sistema puede indicar que hace falta contratar personal adicional.

```txt
Personal que hace falta contratar para proyecto_g:

Nivel = avanzado, Cantidad = 1
```

Esto ocurre porque los proyectos de nivel muy alto requieren 2 desarrolladores avanzados, pero en la base de conocimientos solo existe 1 desarrollador avanzado.

## Explicación general del funcionamiento

El sistema experto utiliza hechos y reglas de Prolog para razonar sobre la asignación de personal.

Primero, se registran los desarrolladores y sus niveles.  
Después, se registran los proyectos y sus niveles de dificultad.  
Luego, se definen los requerimientos de personal para cada tipo de proyecto.  

Con esa información, el sistema puede comparar el personal disponible contra el personal requerido y determinar si un proyecto puede realizarse o si hace falta contratar más programadores.

## Objetivo académico

El objetivo de este proyecto es practicar el desarrollo de sistemas expertos utilizando hechos, reglas y consultas lógicas mediante Tau-Prolog.

El sistema demuestra cómo una base de conocimientos puede utilizarse para tomar decisiones relacionadas con la asignación de personal en proyectos de software.


