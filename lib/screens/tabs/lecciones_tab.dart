import 'package:flutter/material.dart';

class LeccionesTab extends StatefulWidget {
  @override
  _LeccionesTabState createState() => _LeccionesTabState();
}

class _LeccionesTabState extends State<LeccionesTab> {
  int puntos = 0;
  int leccionActual = -1; // -1 indica que no se ha abierto ninguna lección
  bool mostrandoPreguntas = false;

  // Lecciones de ejemplo
  final List<Map<String, dynamic>> lecciones = [
    {
      "titulo": "Introducción a las Finanzas",
      "contenido": "Las finanzas son el arte y la ciencia de gestionar el dinero, abarcando el proceso de planificación, obtención, gasto y ahorro de los recursos económicos. La gestión financiera es clave tanto a nivel personal como empresarial para asegurar la estabilidad económica y el crecimiento. Las finanzas personales son fundamentales para garantizar que una persona pueda alcanzar sus metas a corto y largo plazo, manejar sus gastos diarios y ahorrar para el futuro. Un aspecto importante de las finanzas personales es entender la diferencia entre ingresos, que son los recursos que recibimos, y los gastos, que son los recursos que destinamos para cubrir nuestras necesidades y deseos. Además, el ahorro es una estrategia crucial para asegurar que podamos cubrir emergencias, planificar objetivos a largo plazo como la compra de una casa o un automóvil, o incluso prepararnos para la jubilación. Esta lección te ayudará a entender estos conceptos básicos y te proporcionará herramientas para mejorar tu bienestar financiero. Es importante recordar que tener un control adecuado de tus finanzas te permitirá vivir de manera más tranquila y tomar decisiones informadas sobre cómo manejar tu dinero.",
      "habilitada": true,
      "preguntas": [
        {
          "pregunta": "¿Qué son las finanzas?",
          "opciones": [
            "Gestión del dinero",
            "Un tipo de comida",
            "Un deporte"
          ],
          "respuestaCorrecta": "Gestión del dinero",
          "respuestaSeleccionada": null
        },
        {
          "pregunta": "¿Qué es un ingreso?",
          "opciones": [
            "Dinero que gastas",
            "Dinero que recibes",
            "Dinero que pierdes"
          ],
          "respuestaCorrecta": "Dinero que recibes",
          "respuestaSeleccionada": null
        },
        {
          "pregunta": "¿Qué es el ahorro?",
          "opciones": [
            "Dinero que inviertes",
            "Dinero que guardas",
            "Dinero que gastas"
          ],
          "respuestaCorrecta": "Dinero que guardas",
          "respuestaSeleccionada": null
        },
      ],
    },
    {
      "titulo": "Planificación Financiera",
      "contenido": "Esta lección está bloqueada. Solo puedes acceder a la primera lección.",
      "habilitada": false,
      "preguntas": [],
    },
    {
      "titulo": "Invertir para el Futuro",
      "contenido": "Esta lección está bloqueada. Solo puedes acceder a la primera lección.",
      "habilitada": false,
      "preguntas": [],
    },
  ];

  void reiniciarEstado() {
    setState(() {
      leccionActual = -1;
      mostrandoPreguntas = false;
      puntos = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (leccionActual == -1) {
      // Mostrar listado de lecciones
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lecciones de Finanzas",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: lecciones.length,
                itemBuilder: (context, index) {
                  final leccion = lecciones[index];
                  return Card(
                    color: leccion["habilitada"]
                        ? Colors.white
                        : Colors.grey[300],
                    child: ListTile(
                      title: Text(leccion["titulo"]),
                      subtitle: Text(leccion["habilitada"]
                          ? "Haz clic para abrir"
                          : "Lección bloqueada"),
                      onTap: leccion["habilitada"]
                          ? () {
                              setState(() {
                                leccionActual = index;
                              });
                            }
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else if (mostrandoPreguntas) {
      // Mostrar preguntas de la lección
      final leccion = lecciones[leccionActual];
      final preguntas = leccion["preguntas"];
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leccion["titulo"],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Responde las siguientes preguntas:"),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: preguntas.length,
                itemBuilder: (context, index) {
                  final pregunta = preguntas[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pregunta["pregunta"],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          ...pregunta["opciones"].map<Widget>((opcion) {
                            return ListTile(
                              title: Text(opcion),
                              leading: Radio<String>(
                                value: opcion,
                                groupValue: pregunta["respuestaSeleccionada"],
                                onChanged: (value) {
                                  setState(() {
                                    pregunta["respuestaSeleccionada"] = value;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                int nuevosPuntos = 0;
                for (var pregunta in preguntas) {
                  if (pregunta["respuestaSeleccionada"] ==
                      pregunta["respuestaCorrecta"]) {
                    nuevosPuntos++;
                  }
                }
                setState(() {
                  puntos = nuevosPuntos;
                  reiniciarEstado();
                });
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Resultados"),
                      content: Text(
                          "Puntaje final: $puntos/${preguntas.length} puntos."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Aceptar"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("Enviar Respuestas"),
            ),
          ],
        ),
      );
    } else {
      // Mostrar contenido de la lección
      final leccion = lecciones[leccionActual];
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: reiniciarEstado,
              child: const Text("Volver al Listado"),
            ),
            const SizedBox(height: 16),
            Text(
              leccion["titulo"],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(leccion["contenido"]),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  mostrandoPreguntas = true;
                });
              },
              child: const Text("Responder Preguntas"),
            ),
          ],
        ),
      );
    }
  }
}
