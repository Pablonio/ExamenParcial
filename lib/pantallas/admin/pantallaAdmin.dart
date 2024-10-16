import 'package:flutter/material.dart';
import 'package:myapp/widgets/listdaPublicaciones.dart';
import 'crearPublicacionPantalla.dart';
import 'crearUsuarioPantalla.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Administrador - Panel de Control')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CrearPublicacionPantalla()));
            },
            child: Text('Crear Nueva Publicación'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CrearUsuarioPantalla()));
            },
            child: Text('Crear Nuevo Usuario'),
          ),
          Expanded(
              child: PublicationList(
                  isAdmin: true)), // Usamos el widget reutilizable
        ],
      ),
    );
  }
}
