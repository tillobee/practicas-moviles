import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../models/post_model.dart';

class DatabaseHelper {
  static final nameDB = 'socialDB';
  static final version = 1;

  static Database? _database;
  
  Future<Database> get database async {
    if(_database != null) return _database!;
    return _database=_initDatabase();
  }

  _initDatabase() async{
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path,nameDB);
    await openDatabase(
      pathDB,
      version: version,
      onCreate: _createTables
    );
  }

  _createTables(Database db, int version) async{
    String query = '''CREATE TABLE post(
        idPost INTEGER PRIMARY KEY, 
        descripcion VARCHAR(200),
        date DATE
    )''';
    db.execute(query);
  }

  Future<int> insert(String tblName, Map<String,dynamic> data) async {
    var conexion = await database;
    return conexion.insert(tblName, data);
  }

  Future<int> update(String tblName, Map<String,dynamic> data) async{
    var con = await database;
    return con.update(tblName, data,where: 'idPost=?',whereArgs: [data['idPost']] );
  }

  Future<int> delete(String tblName, int idPost) async{
    var con = await database;
    return con.delete(tblName,where:'idPost=?', whereArgs: [idPost] );
  }

  Future<List<PostModel>>getPosts() async{
    var con = await database;
    var rs=await con.query('post');
    return rs.map((post) => PostModel.fromMap(post)).toList();
  }

}