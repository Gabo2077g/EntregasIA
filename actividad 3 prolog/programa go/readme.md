# Sistema Experto para Control de Ingredientes de un Menú

Este proyecto es un programa desarrollado en Go que funciona como un sistema experto básico para apoyar a un cocinero en el control de ingredientes de diferentes guisos o platillos de un menú.

## Objetivo

El programa permite consultar qué ingredientes lleva un platillo, verificar si existen todos los ingredientes necesarios para prepararlo y mostrar una lista de ingredientes faltantes en caso de que no se pueda preparar.

## Funciones principales

- Mostrar los platillos disponibles.
- Consultar los ingredientes de un platillo.
- Verificar si un platillo puede prepararse con los ingredientes disponibles.
- Mostrar los ingredientes faltantes para un platillo.
- Mostrar el inventario actual.
- Agregar nuevos ingredientes al inventario.

## Platillos registrados

El sistema incluye los siguientes platillos:

- Tacos de pollo
- Enchiladas verdes
- Arroz rojo
- Mole de pollo
- Chilaquiles

## Tecnologías utilizadas

- Lenguaje Go
- Uso de estructuras `struct`
- Uso de arreglos dinámicos `slice`
- Uso de funciones
- Uso de condicionales `if`
- Uso de ciclos `for`
- Uso de `switch`

## Cómo ejecutar el programa

Primero se debe tener instalado Go en la computadora.

Después, en la terminal, dentro de la carpeta del proyecto, ejecutar:

```bash
go run main.go