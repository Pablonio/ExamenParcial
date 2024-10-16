import 'dart:io'; // Importar la clase File para manejar archivos
import 'package:flutter/material.dart';
import 'package:myapp/modelos/pubModelo.dart';

class PublicationDetailsScreen extends StatelessWidget {
  final Publication publication;

  PublicationDetailsScreen({required this.publication});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(publication.title)),
      // Asegúrate de que el contenido se ajuste cuando sube el teclado
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        // Permitir desplazamiento cuando sea necesario
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                publication.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                publication.content,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              if (publication.imagePath != null) // Mostrar imagen en detalles
                Image.file(
                  File(publication
                      .imagePath!), // Mostrar imagen desde la ruta del archivo
                  height: 200,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Likes: ${publication.likes}'),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () {
                      // Acción de dar like
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
