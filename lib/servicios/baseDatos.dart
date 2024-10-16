import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:myapp/modelos/usuarioModelo.dart';
import 'package:myapp/modelos/pubModelo.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    return _db!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'app_blog.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT,
        role TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE Publicaciones(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        likes INTEGER DEFAULT 0,
        imagePath TEXT,
        userId INTEGER,
        FOREIGN KEY (userId) REFERENCES Usuarios(id) ON DELETE CASCADE
      )
    ''');

    // Insertar admin por defecto
    await db.insert('Usuarios',
        {'username': 'admin', 'password': 'admin', 'role': 'admin'});
  }

  // Obtener todas las publicaciones
  Future<List<Publication>> getPublications() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps =
        await dbClient.query('Publicaciones');

    if (maps.isEmpty) return [];

    return List.generate(maps.length, (i) {
      return Publication(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
        likes: maps[i]['likes'],
        imagePath: maps[i]['imagePath'],
        userId: maps[i]['userId'],
      );
    });
  }

  // Crear una publicación
  Future<void> createPublication(Publication publication) async {
    var dbClient = await db;
    await dbClient.insert('Publicaciones', publication.toMap());
  }

  // Incrementar likes de una publicación
  Future<void> likePublication(int id) async {
    var dbClient = await db;
    await dbClient.rawUpdate(
        'UPDATE Publicaciones SET likes = likes + 1 WHERE id = ?', [id]);
  }

  // Obtener todos los usuarios
  Future<List<User>> getUsers() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('Usuarios');

    if (maps.isEmpty) return [];

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['username'],
        password: maps[i]['password'],
        role: maps[i]['role'],
      );
    });
  }

  // Crear un usuario
  Future<void> createUser(User user) async {
    var dbClient = await db;
    await dbClient.insert('Usuarios', user.toMap());
  }

  // Obtener un usuario por su ID
  Future<User?> getUserById(int userId) async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query(
      'Usuarios',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return User(
        id: maps[0]['id'],
        username: maps[0]['username'],
        password: maps[0]['password'],
        role: maps[0]['role'],
      );
    }

    return null;
  }
}
