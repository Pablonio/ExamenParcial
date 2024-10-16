import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pantallas/inicioSesionPantalla.dart';
import 'servicios/inicioCheck.dart';
import 'pantallas/admin/pantallaAdmin.dart';
import 'pantallas/cliente/clienteDashoarPantalla.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App de Blog Universitario',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            if (authProvider.isLoggedIn) {
              return authProvider.role == 'admin' ? AdminDashboard() : ClientDashboard();
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
