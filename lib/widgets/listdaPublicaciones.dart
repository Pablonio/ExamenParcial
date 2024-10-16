import 'package:flutter/material.dart';
import 'package:myapp/servicios/baseDatos.dart';
import 'package:myapp/modelos/pubModelo.dart';
import 'package:myapp/modelos/usuarioModelo.dart';

class PublicationList extends StatelessWidget {
  final bool isAdmin;

  PublicationList({this.isAdmin = false});

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
            return FutureBuilder<User?>(
              future: DBHelper().getUserById(publication.userId),
              builder: (context, userSnapshot) {
                if (!userSnapshot.hasData) {
                  return ListTile(
                    title: Text(publication.title),
                    subtitle: Text('Cargando creador...'),
                  );
                }

                var creator = userSnapshot.data!;
                return ListTile(
                  title: Text(publication.title),
                  subtitle: Text(
                      'Creador: ${creator.username}\nLikes: ${publication.likes}'),
                  trailing: IconButton(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () async {
                      await DBHelper().likePublication(publication.id!);
                      // Aquí podrías implementar una manera de refrescar el estado para mostrar los likes actualizados
                    },
                  ),
                  onTap: () {
                    // Aquí se puede navegar a los detalles de la publicación
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
