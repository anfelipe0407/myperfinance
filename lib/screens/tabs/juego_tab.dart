import 'package:flutter/material.dart';

class PuntajeYAvatarTab extends StatefulWidget {
  @override
  _PuntajeYAvatarTabState createState() => _PuntajeYAvatarTabState();
}

class _PuntajeYAvatarTabState extends State<PuntajeYAvatarTab> {
  int puntajeTotal = 120; // Puntaje total del usuario
  int monedas = 50; // Monedas del usuario
  List<String> insignias = ['Ahorro experto', 'Financiero principiante']; // Insignias del usuario
  String avatarImagen = 'assets/avatar/usuario_default.png'; // Imagen del avatar (default)

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título y subtítulo
          Text(
            "Mi Perfil",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text("Puntaje total: $puntajeTotal puntos"),
          const SizedBox(height: 8),

          // Avatar y monedas
          Row(
            children: [
              Container(
  padding: const EdgeInsets.all(8.0), // Ajusta el padding como desees
  decoration: BoxDecoration(
    shape: BoxShape.circle, // Asegura que el contenedor tenga forma circular
  ),
  child: CircleAvatar(
    radius: 50,
    backgroundImage: AssetImage(avatarImagen),
  ),
),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Monedas: $monedas",
                    style: TextStyle(fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Aquí iría la lógica de la tienda para personalizar el avatar
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Tienda de Avatar"),
                            content: Text("Aquí puedes comprar accesorios para tu avatar."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cerrar"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Ir a la tienda"),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Insignias
          Text(
            "Insignias:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Column(
            children: insignias.map((insignia) {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 8),
                      Text(insignia),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // Botón de volver
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   child: const Text("Volver al menú principal"),
          // ),
        ],
      ),
    );
  }
}
