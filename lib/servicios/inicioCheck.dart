import 'package:flutter/material.dart';
import 'baseDatos.dart';

class AuthProvider with ChangeNotifier {
  bool isLoggedIn = false;
  String? role;

  Future<void> login(String username, String password) async {
    var db = await DBHelper().db;
    var result = await db.rawQuery(
        'SELECT * FROM Usuarios WHERE username = ? AND password = ?',
        [username, password]);

    if (result.isNotEmpty) {
      isLoggedIn = true;
      role = result.first['role'] as String;
      notifyListeners();
    }
  }

  void logout() {
    isLoggedIn = false;
    role = null;
    notifyListeners();
  }
}
