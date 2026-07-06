package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

/*
	SISTEMA EXPERTO PARA CONTROL DE INGREDIENTES DE UN MENÚ

	Este programa permite:
	1. Mostrar los platillos disponibles.
	2. Consultar qué ingredientes lleva un platillo.
	3. Verificar si existen todos los ingredientes para preparar un platillo.
	4. Mostrar una lista de ingredientes faltantes.
	5. Agregar ingredientes al inventario.

	La base de conocimiento está formada por los platillos y sus ingredientes.
	El inventario representa los ingredientes disponibles en cocina.
*/

// Platillo representa un guiso del menú y sus ingredientes.
type Platillo struct {
	Nombre       string
	Ingredientes []string
}

// Función principal del programa.
func main() {
	reader := bufio.NewReader(os.Stdin)

	// Base de conocimiento: platillos del menú.
	platillos := []Platillo{
		{
			Nombre: "tacos de pollo",
			Ingredientes: []string{
				"tortilla", "pollo", "cebolla", "cilantro", "limon", "sal",
			},
		},
		{
			Nombre: "enchiladas verdes",
			Ingredientes: []string{
				"tortilla", "pollo", "salsa verde", "crema", "queso", "cebolla", "aceite",
			},
		},
		{
			Nombre: "arroz rojo",
			Ingredientes: []string{
				"arroz", "tomate", "ajo", "cebolla", "aceite", "sal",
			},
		},
		{
			Nombre: "mole de pollo",
			Ingredientes: []string{
				"pollo", "mole", "arroz", "sal", "tortilla",
			},
		},
		{
			Nombre: "chilaquiles",
			Ingredientes: []string{
				"tortilla", "salsa verde", "crema", "queso", "cebolla",
			},
		},
	}

	// Ingredientes disponibles en cocina.
	inventario := []string{
		"tortilla", "pollo", "cebolla", "cilantro", "limon",
		"sal", "arroz", "tomate", "ajo", "aceite", "queso", "crema",
	}

	opcion := 0

	for opcion != 6 {
		fmt.Println("\n======================================")
		fmt.Println(" SISTEMA EXPERTO - MENÚ DE GUISOS")
		fmt.Println("======================================")
		fmt.Println("1. Ver platillos disponibles")
		fmt.Println("2. Ver ingredientes de un platillo")
		fmt.Println("3. Verificar si se puede preparar un platillo")
		fmt.Println("4. Ver inventario disponible")
		fmt.Println("5. Agregar ingrediente al inventario")
		fmt.Println("6. Salir")
		fmt.Print("Seleccione una opción: ")

		textoOpcion := leerTexto(reader)
		opcionConvertida, errorConversion := strconv.Atoi(textoOpcion)

		if errorConversion != nil {
			fmt.Println("Opción inválida. Escriba un número del 1 al 6.")
			continue
		}

		opcion = opcionConvertida

		switch opcion {
		case 1:
			mostrarPlatillos(platillos)

		case 2:
			fmt.Print("Escriba el nombre del platillo: ")
			nombre := leerTexto(reader)

			platillo, encontrado := buscarPlatillo(platillos, nombre)

			if encontrado {
				mostrarIngredientes(platillo)
			} else {
				fmt.Println("No se encontró ese platillo en el menú.")
			}

		case 3:
			fmt.Print("Escriba el nombre del platillo a verificar: ")
			nombre := leerTexto(reader)

			platillo, encontrado := buscarPlatillo(platillos, nombre)

			if encontrado {
				verificarPlatillo(platillo, inventario)
			} else {
				fmt.Println("No se encontró ese platillo en el menú.")
			}

		case 4:
			mostrarInventario(inventario)

		case 5:
			fmt.Print("Escriba el nombre del ingrediente a agregar: ")
			ingrediente := leerTexto(reader)

			if ingrediente == "" {
				fmt.Println("No se agregó ningún ingrediente.")
			} else if existeIngrediente(inventario, ingrediente) {
				fmt.Println("El ingrediente ya existe en el inventario.")
			} else {
				inventario = append(inventario, ingrediente)
				fmt.Println("Ingrediente agregado correctamente al inventario.")
			}

		case 6:
			fmt.Println("Saliendo del sistema experto...")

		default:
			fmt.Println("Opción inválida. Escriba un número del 1 al 6.")
		}
	}
}

// leerTexto lee una línea escrita por el usuario.
func leerTexto(reader *bufio.Reader) string {
	texto, _ := reader.ReadString('\n')
	texto = strings.TrimSpace(texto)
	texto = strings.ToLower(texto)

	return texto
}

// mostrarPlatillos muestra todos los platillos registrados en el menú.
func mostrarPlatillos(platillos []Platillo) {
	fmt.Println("\nPlatillos disponibles:")

	for i := 0; i < len(platillos); i++ {
		fmt.Println("-", platillos[i].Nombre)
	}
}

// buscarPlatillo busca un platillo por su nombre.
func buscarPlatillo(platillos []Platillo, nombre string) (Platillo, bool) {
	for i := 0; i < len(platillos); i++ {
		if platillos[i].Nombre == nombre {
			return platillos[i], true
		}
	}

	return Platillo{}, false
}

// mostrarIngredientes muestra los ingredientes de un platillo.
func mostrarIngredientes(platillo Platillo) {
	fmt.Println("\nIngredientes de", platillo.Nombre+":")

	for i := 0; i < len(platillo.Ingredientes); i++ {
		fmt.Println("-", platillo.Ingredientes[i])
	}
}

// existeIngrediente verifica si un ingrediente se encuentra en el inventario.
func existeIngrediente(inventario []string, ingrediente string) bool {
	for i := 0; i < len(inventario); i++ {
		if inventario[i] == ingrediente {
			return true
		}
	}

	return false
}

// obtenerIngredientesFaltantes compara los ingredientes del platillo con el inventario.
func obtenerIngredientesFaltantes(platillo Platillo, inventario []string) []string {
	faltantes := []string{}

	for i := 0; i < len(platillo.Ingredientes); i++ {
		ingrediente := platillo.Ingredientes[i]

		if !existeIngrediente(inventario, ingrediente) {
			faltantes = append(faltantes, ingrediente)
		}
	}

	return faltantes
}

// verificarPlatillo indica si se puede preparar un platillo o qué ingredientes faltan.
func verificarPlatillo(platillo Platillo, inventario []string) {
	faltantes := obtenerIngredientesFaltantes(platillo, inventario)

	fmt.Println("\nResultado de la verificación:")

	if len(faltantes) == 0 {
		fmt.Println("Sí se puede preparar:", platillo.Nombre)
		fmt.Println("Existen todos los ingredientes necesarios.")
	} else {
		fmt.Println("No se puede preparar:", platillo.Nombre)
		fmt.Println("Ingredientes faltantes:")

		for i := 0; i < len(faltantes); i++ {
			fmt.Println("-", faltantes[i])
		}
	}
}

// mostrarInventario muestra los ingredientes disponibles en cocina.
func mostrarInventario(inventario []string) {
	fmt.Println("\nIngredientes disponibles en inventario:")

	for i := 0; i < len(inventario); i++ {
		fmt.Println("-", inventario[i])
	}
}