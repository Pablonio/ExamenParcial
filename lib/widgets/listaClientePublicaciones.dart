import 'dart:io'; // Importación necesaria para File
import 'package:flutter/material.dart';
import 'package:myapp/servicios/baseDatos.dart';
import 'package:myapp/modelos/pubModelo.dart';
import 'package:myapp/pantallas/cliente/detallesPublicacionPantalla.dart';

class ClientPublicationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Publication>>(
      future: DBHelper().getPublications(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<Publication> publications = snapshot.data!;

        return ListView.builder(
          itemCount: publications.length,
          itemBuilder: (context, index) {
            var publication = publications[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListTile(
                title: Text(publication.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Likes: ${publication.likes}'),
                    if (publication.imagePath != null &&
                        publication.imagePath!.isNotEmpty)
                      Image.file(
                        File(publication
                            .imagePath!), // Cargar la imagen desde el archivo local
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PublicationDetailsScreen(publication: publication),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () async {
                    await DBHelper().likePublication(publication.id!);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
