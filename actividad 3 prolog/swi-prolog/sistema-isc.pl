:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).
:- use_module(library(lists)).
:- use_module(library(pairs)).

/* =========================================================
   SERVIDOR
   ========================================================= */

server(Port) :-
    http_server(http_dispatch, [port(Port)]).

:- http_handler(root(materias), handle_materias, []).
:- http_handler(root(materias_semestre), handle_materias_semestre, []).
:- http_handler(root(materias_area), handle_materias_area, []).
:- http_handler(root(alumno), handle_alumno_info, []).
:- http_handler(root(alumno_historial), handle_alumno_historial, []).
:- http_handler(root(alumno_baja), handle_alumno_baja, []).
:- http_handler(root(alumno_candidatas), handle_alumno_candidatas, []).
:- http_handler(root(alumno_recomendar), handle_alumno_recomendar, []).
:- http_handler(root(alumnos_alto_rendimiento), handle_alumnos_alto_rendimiento, []).
:- http_handler(root(curso_aspirantes), handle_curso_aspirantes, []).

/* =========================================================
   BASE DE CONOCIMIENTO
   Materia: id, nombre, semestre, area, creditos
   ========================================================= */

materia(matematicas1, 'Matemáticas I', 1, matematicas, 5).
materia(introduccion_isc, 'Introducción a ISC', 1, basica, 4).
materia(fundamentos_programacion, 'Fundamentos de Programación', 1, programacion, 5).
materia(etica, 'Ética', 1, humanidades, 3).

materia(matematicas2, 'Matemáticas II', 2, matematicas, 5).
materia(programacion_orientada_objetos, 'Programación Orientada a Objetos', 2, programacion, 5).
materia(base_datos, 'Base de Datos', 2, datos, 5).
materia(redes1, 'Redes I', 2, redes, 4).

materia(ingenieria_software, 'Ingeniería de Software', 3, software, 5).
materia(programacion_web, 'Programación Web', 3, programacion, 5).
materia(inteligencia_artificial, 'Inteligencia Artificial', 3, inteligencia_artificial, 5).
materia(redes2, 'Redes II', 3, redes, 4).

materia(sistemas_expertos, 'Sistemas Expertos', 4, inteligencia_artificial, 5).
materia(ciberseguridad, 'Ciberseguridad', 4, seguridad, 5).

/* =========================================================
   SERIACIÓN
   requisito(Materia, MateriaRequisito)
   ========================================================= */

requisito(matematicas2, matematicas1).
requisito(programacion_orientada_objetos, fundamentos_programacion).
requisito(base_datos, fundamentos_programacion).
requisito(redes2, redes1).

requisito(ingenieria_software, programacion_orientada_objetos).
requisito(programacion_web, programacion_orientada_objetos).
requisito(programacion_web, base_datos).

requisito(inteligencia_artificial, matematicas2).
requisito(inteligencia_artificial, programacion_orientada_objetos).

requisito(sistemas_expertos, inteligencia_artificial).
requisito(sistemas_expertos, base_datos).

requisito(ciberseguridad, redes2).

/* =========================================================
   ALUMNOS
   alumno(id, nombre, programa)
   ========================================================= */

alumno(a001, 'Ana López', isc).
alumno(a002, 'Luis Pérez', isc).
alumno(a003, 'Carla Gómez', isc).
alumno(a004, 'Diego Torres', isc).
alumno(a005, 'Sofía Ramírez', isc).

/* =========================================================
   HISTORIAL ACADÉMICO
   historial(Alumno, Materia, Intento, Calificacion)
   ========================================================= */

historial(a001, matematicas1, 1, 95).
historial(a001, introduccion_isc, 1, 90).
historial(a001, fundamentos_programacion, 1, 92).
historial(a001, etica, 1, 88).
historial(a001, matematicas2, 1, 93).
historial(a001, programacion_orientada_objetos, 1, 91).
historial(a001, base_datos, 1, 96).

historial(a002, matematicas1, 1, 65).
historial(a002, matematicas1, 2, 80).
historial(a002, introduccion_isc, 1, 75).
historial(a002, fundamentos_programacion, 1, 68).
historial(a002, fundamentos_programacion, 2, 72).

historial(a003, matematicas1, 1, 60).
historial(a003, matematicas1, 2, 55).
historial(a003, matematicas1, 3, 58).

historial(a004, matematicas1, 1, 82).
historial(a004, introduccion_isc, 1, 78).
historial(a004, fundamentos_programacion, 1, 60).
historial(a004, etica, 1, 90).

historial(a005, matematicas1, 1, 91).
historial(a005, introduccion_isc, 1, 95).
historial(a005, fundamentos_programacion, 1, 90).
historial(a005, etica, 1, 95).
historial(a005, matematicas2, 1, 90).
historial(a005, programacion_orientada_objetos, 1, 88).
historial(a005, base_datos, 1, 92).
historial(a005, redes1, 1, 90).
historial(a005, redes2, 1, 91).
historial(a005, inteligencia_artificial, 1, 94).

/* =========================================================
   REGLAS DEL SISTEMA EXPERTO
   ========================================================= */

aprobada(Alumno, Materia) :-
    historial(Alumno, Materia, _, Calificacion),
    Calificacion >= 70.

intentos(Alumno, Materia, Total) :-
    aggregate_all(count, historial(Alumno, Materia, _, _), Total).

intentos_reprobados(Alumno, Materia, Total) :-
    aggregate_all(count, (
        historial(Alumno, Materia, _, Calificacion),
        Calificacion < 70
    ), Total).

baja_materia(Alumno, Materia) :-
    materia(Materia, _, _, _, _),
    intentos_reprobados(Alumno, Materia, Total),
    Total >= 3.

baja_alumno(Alumno) :-
    baja_materia(Alumno, _).

ultimo_intento_calificacion(Alumno, Materia, Intento, Calificacion) :-
    findall(I-C, historial(Alumno, Materia, I, C), Pares),
    keysort(Pares, Ordenados),
    last(Ordenados, Intento-Calificacion).

materias_con_historial(Alumno, Materias) :-
    setof(Materia, I^C^historial(Alumno, Materia, I, C), Materias),
    !.
materias_con_historial(_, []).

tiene_historial(Alumno) :-
    historial(Alumno, _, _, _).

promedio_general(Alumno, Promedio) :-
    materias_con_historial(Alumno, Materias),
    Materias \= [],
    findall(Calificacion, (
        member(Materia, Materias),
        ultimo_intento_calificacion(Alumno, Materia, _, Calificacion)
    ), Calificaciones),
    sum_list(Calificaciones, Suma),
    length(Calificaciones, Total),
    Promedio is Suma / Total.

promedio_general(Alumno, 0) :-
    materias_con_historial(Alumno, []).

alto_rendimiento(Alumno) :-
    promedio_general(Alumno, Promedio),
    Promedio >= 90,
    \+ baja_alumno(Alumno).

reprobadas_vigentes(Alumno, Reprobadas) :-
    setof(Materia, (
        materia(Materia, _, _, _, _),
        ultimo_intento_calificacion(Alumno, Materia, _, Calificacion),
        Calificacion < 70,
        \+ aprobada(Alumno, Materia)
    ), Reprobadas),
    !.
reprobadas_vigentes(_, []).

cantidad_reprobadas_vigentes(Alumno, Total) :-
    reprobadas_vigentes(Alumno, Reprobadas),
    length(Reprobadas, Total).

carga_maxima(Alumno, 0) :-
    baja_alumno(Alumno),
    !.

carga_maxima(Alumno, 4) :-
    tiene_historial(Alumno),
    promedio_general(Alumno, Promedio),
    Promedio < 80,
    !.

carga_maxima(Alumno, 4) :-
    cantidad_reprobadas_vigentes(Alumno, Total),
    Total > 1,
    !.

carga_maxima(_, 6).

cumple_requisitos(Alumno, Materia) :-
    forall(requisito(Materia, Requisito), aprobada(Alumno, Requisito)).

puede_cursar(Alumno, Materia) :-
    alumno(Alumno, _, isc),
    materia(Materia, _, _, _, _),
    \+ aprobada(Alumno, Materia),
    \+ baja_alumno(Alumno),
    cumple_requisitos(Alumno, Materia).

materias_posibles_ordenadas(Alumno, Materias) :-
    findall(Semestre-Materia, (
        puede_cursar(Alumno, Materia),
        materia(Materia, _, Semestre, _, _)
    ), Pares),
    keysort(Pares, Ordenados),
    pairs_values(Ordenados, Materias).

tomar(0, _, []) :- !.
tomar(_, [], []) :- !.
tomar(N, [X|Xs], [X|Ys]) :-
    N > 0,
    N1 is N - 1,
    tomar(N1, Xs, Ys).

recomendar_materias(Alumno, []) :-
    carga_maxima(Alumno, 0),
    !.

recomendar_materias(Alumno, Recomendadas) :-
    carga_maxima(Alumno, Maximo),
    materias_posibles_ordenadas(Alumno, Posibles),
    tomar(Maximo, Posibles, Recomendadas).

aspirantes_materia(Materia, Aspirantes) :-
    findall(Alumno, (
        alumno(Alumno, _, isc),
        puede_cursar(Alumno, Materia)
    ), Lista),
    sort(Lista, Aspirantes).

estado_materia(Alumno, Materia, aprobada) :-
    aprobada(Alumno, Materia),
    !.
estado_materia(Alumno, Materia, reprobada) :-
    ultimo_intento_calificacion(Alumno, Materia, _, Calificacion),
    Calificacion < 70,
    !.
estado_materia(_, _, sin_cursar).

estado_alumno(Alumno, baja) :-
    baja_alumno(Alumno),
    !.
estado_alumno(_, activo).

redondear(Numero, Redondeado) :-
    Redondeado is round(Numero * 100) / 100.

/* =========================================================
   CONVERSIÓN A JSON
   ========================================================= */

materia_dict(Materia, Dict) :-
    materia(Materia, Nombre, Semestre, Area, Creditos),
    findall(Requisito, requisito(Materia, Requisito), Requisitos),
    Dict = _{
        id: Materia,
        nombre: Nombre,
        semestre: Semestre,
        area: Area,
        creditos: Creditos,
        requisitos: Requisitos
    }.

alumno_resumen_dict(Alumno, Dict) :-
    alumno(Alumno, Nombre, Programa),
    promedio_general(Alumno, Promedio),
    redondear(Promedio, PromedioRedondeado),
    cantidad_reprobadas_vigentes(Alumno, Reprobadas),
    carga_maxima(Alumno, CargaMaxima),
    estado_alumno(Alumno, Estado),
    Dict = _{
        id: Alumno,
        nombre: Nombre,
        programa: Programa,
        promedio_general: PromedioRedondeado,
        reprobadas_vigentes: Reprobadas,
        carga_maxima: CargaMaxima,
        estado: Estado
    }.

alumno_basico_dict(Alumno, Dict) :-
    alumno(Alumno, Nombre, Programa),
    promedio_general(Alumno, Promedio),
    redondear(Promedio, PromedioRedondeado),
    Dict = _{
        id: Alumno,
        nombre: Nombre,
        programa: Programa,
        promedio_general: PromedioRedondeado
    }.

resultado_calificacion(Calificacion, aprobado) :-
    Calificacion >= 70,
    !.
resultado_calificacion(_, reprobado).

historial_materia_dict(Alumno, Materia, Dict) :-
    intentos(Alumno, Materia, TotalIntentos),
    estado_materia(Alumno, Materia, Estado),
    findall(Intento-Detalle, (
        historial(Alumno, Materia, Intento, Calificacion),
        resultado_calificacion(Calificacion, Resultado),
        Detalle = _{
            intento: Intento,
            calificacion: Calificacion,
            resultado: Resultado
        }
    ), Pares),
    keysort(Pares, Ordenados),
    pairs_values(Ordenados, Calificaciones),
    Dict = _{
        materia: Materia,
        intentos: TotalIntentos,
        estado: Estado,
        calificaciones: Calificaciones
    }.

historial_alumno(Alumno, Historial) :-
    materias_con_historial(Alumno, Materias),
    findall(Dict, (
        member(Materia, Materias),
        historial_materia_dict(Alumno, Materia, Dict)
    ), Historial).

error_json(Codigo, Mensaje) :-
    reply_json_dict(_{error: Mensaje}, [status(Codigo)]).

/* =========================================================
   ENDPOINTS
   ========================================================= */

handle_materias(_) :-
    findall(Dict, (
        materia(Materia, _, _, _, _),
        materia_dict(Materia, Dict)
    ), Materias),
    reply_json_dict(_{materias: Materias}).

handle_materias_semestre(Request) :-
    http_parameters(Request, [
        semestre(Semestre, [integer])
    ]),
    findall(Dict, (
        materia(Materia, _, Semestre, _, _),
        materia_dict(Materia, Dict)
    ), Materias),
    reply_json_dict(_{
        semestre: Semestre,
        materias: Materias
    }).

handle_materias_area(Request) :-
    http_parameters(Request, [
        area(Area, [atom])
    ]),
    findall(Dict, (
        materia(Materia, _, _, Area, _),
        materia_dict(Materia, Dict)
    ), Materias),
    reply_json_dict(_{
        area: Area,
        materias: Materias
    }).

handle_alumno_info(Request) :-
    http_parameters(Request, [
        id(Alumno, [atom])
    ]),
    (
        alumno(Alumno, _, _) ->
        alumno_resumen_dict(Alumno, Dict),
        reply_json_dict(Dict)
        ;
        error_json(404, 'Alumno no encontrado')
    ).

handle_alumno_historial(Request) :-
    http_parameters(Request, [
        id(Alumno, [atom]),
        materia(Materia, [atom, optional(true)])
    ]),
    (
        \+ alumno(Alumno, _, _) ->
        error_json(404, 'Alumno no encontrado')
        ;
        var(Materia) ->
        historial_alumno(Alumno, Historial),
        reply_json_dict(_{
            alumno: Alumno,
            historial: Historial
        })
        ;
        materia(Materia, _, _, _, _) ->
        historial_materia_dict(Alumno, Materia, HistorialMateria),
        reply_json_dict(_{
            alumno: Alumno,
            historial: HistorialMateria
        })
        ;
        error_json(404, 'Materia no encontrada')
    ).

handle_alumno_baja(Request) :-
    http_parameters(Request, [
        id(Alumno, [atom])
    ]),
    (
        \+ alumno(Alumno, _, _) ->
        error_json(404, 'Alumno no encontrado')
        ;
        findall(_{materia: Materia, intentos_reprobados: Intentos}, (
            baja_materia(Alumno, Materia),
            intentos_reprobados(Alumno, Materia, Intentos)
        ), MateriasBaja),
        estado_alumno(Alumno, Estado),
        reply_json_dict(_{
            alumno: Alumno,
            estado: Estado,
            materias_causantes: MateriasBaja
        })
    ).

handle_alumno_candidatas(Request) :-
    http_parameters(Request, [
        id(Alumno, [atom])
    ]),
    (
        \+ alumno(Alumno, _, _) ->
        error_json(404, 'Alumno no encontrado')
        ;
        materias_posibles_ordenadas(Alumno, Posibles),
        findall(Dict, (
            member(Materia, Posibles),
            materia_dict(Materia, Dict)
        ), Materias),
        reply_json_dict(_{
            alumno: Alumno,
            materias_candidatas: Materias
        })
    ).

handle_alumno_recomendar(Request) :-
    http_parameters(Request, [
        id(Alumno, [atom])
    ]),
    (
        \+ alumno(Alumno, _, _) ->
        error_json(404, 'Alumno no encontrado')
        ;
        carga_maxima(Alumno, CargaMaxima),
        recomendar_materias(Alumno, Recomendadas),
        findall(Dict, (
            member(Materia, Recomendadas),
            materia_dict(Materia, Dict)
        ), Materias),
        reply_json_dict(_{
            alumno: Alumno,
            carga_maxima: CargaMaxima,
            materias_recomendadas: Materias
        })
    ).

handle_alumnos_alto_rendimiento(_) :-
    findall(Dict, (
        alto_rendimiento(Alumno),
        alumno_resumen_dict(Alumno, Dict)
    ), Alumnos),
    reply_json_dict(_{
        criterio: 'promedio >= 90',
        alumnos: Alumnos
    }).

handle_curso_aspirantes(Request) :-
    http_parameters(Request, [
        materia(Materia, [atom])
    ]),
    (
        \+ materia(Materia, _, _, _, _) ->
        error_json(404, 'Materia no encontrada')
        ;
        aspirantes_materia(Materia, Aspirantes),
        length(Aspirantes, Total),
        findall(Dict, (
            member(Alumno, Aspirantes),
            alumno_basico_dict(Alumno, Dict)
        ), Alumnos),
        reply_json_dict(_{
            materia: Materia,
            posibles_aspirantes: Total,
            alumnos: Alumnos
        })
    ).

/* =========================================================
   ARRANQUE DESDE CONSOLA
   ========================================================= */

:- initialization(main, main).

main :-
    server(8080),
    format('Servidor iniciado en http://localhost:8080~n'),
    format('Presiona Ctrl+C para detenerlo.~n'),
    thread_get_message(_).