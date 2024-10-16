import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/servicios/baseDatos.dart';
import 'package:myapp/modelos/pubModelo.dart';

class CrearPublicacionPantalla extends StatefulWidget {
  @override
  _CrearPublicacionPantallaState createState() =>
      _CrearPublicacionPantallaState();
}

class _CrearPublicacionPantallaState extends State<CrearPublicacionPantalla> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  String? imagePath; // Variable para almacenar la ruta de la imagen

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        imagePath = image.path; // Asignamos la ruta de la imagen seleccionada
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Nueva Publicación')),
      resizeToAvoidBottomInset:
          true, // Permite que el teclado no cause overflow
      body: SingleChildScrollView(
        // Para que el contenido sea desplazable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Contenido'),
                maxLines: 5,
              ),
              SizedBox(height: 20),
              if (imagePath != null) ...[
                Image.file(
                  File(imagePath!),
                  height: MediaQuery.of(context).size.height *
                      0.3, // Ajusta el tamaño de la imagen
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
              ],
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Seleccionar Imagen'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (titleController.text.isNotEmpty &&
                      contentController.text.isNotEmpty) {
                    int userId =
                        1; // Supongamos que obtienes el ID del usuario autenticado aquí
                    Publication newPublication = Publication(
                      title: titleController.text,
                      content: contentController.text,
                      imagePath: imagePath,
                      userId: userId, // Asigna el ID del usuario autenticado
                    );
                    await DBHelper().createPublication(newPublication);
                    Navigator.pop(context); // Regresar a la pantalla anterior
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Por favor, completa todos los campos')));
                  }
                },
                child: Text('Crear'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
