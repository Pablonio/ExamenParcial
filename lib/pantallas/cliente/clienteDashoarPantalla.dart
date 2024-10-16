import 'package:flutter/material.dart';
import 'package:myapp/widgets/listdaPublicaciones.dart';
import 'package:myapp/pantallas/cliente/crearPublicacionPantallla.dart';

class ClientDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blog Universitario')),
      body: PublicationList(isAdmin: false), // Usamos el widget reutilizable
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CrearPublicacionPantalla()), // Navegación a la pantalla de creación
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
