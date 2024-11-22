import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          // Imagen en la parte superior
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/avatar/logo.png', height: 150), // Cambia esto por tu imagen
          ),
          // Espaciado
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,  // Esto asegura que los campos estén centrados
                  children: [
                    // Campo de email
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    SizedBox(height: 20),
                    // Campo de contraseña
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    // Botón de login
                    ElevatedButton(
                      onPressed: () {
                        // Simula el login (aquí puedes añadir lógica real)
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
