import 'package:flutter/material.dart';
import 'package:myapp/servicios/baseDatos.dart';
import 'package:myapp/modelos/usuarioModelo.dart';

class CrearUsuarioPantalla extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Nuevo Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Nombre de Usuario'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: roleController,
              decoration: InputDecoration(labelText: 'Rol (admin/cliente)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                User newUser = User(
                  username: usernameController.text,
                  password: passwordController.text,
                  role: roleController.text,
                );
                await DBHelper().createUser(newUser);
                Navigator.pop(context);
              },
              child: Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }
}
