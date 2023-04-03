import 'dart:io';

import 'package:login/models/event_model.dart';
import 'package:login/models/favourite_model.dart';
import 'package:login/models/post_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  
  static final nameDB = 'SOCIALDB';
  static final versionDB = 5;
  static final newVersionDB = 5;

  static Database? _database;
  Future<Database> get database async {
    if( _database != null ) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async{
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path,nameDB);
    return await openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables,
      onUpgrade: ((Database db, int oldV, int newV){
        String query = '''
          CREATE TABLE IF NOT EXISTS favorito(
            id INTEGER PRIMARY KEY,
            posterPath VARCHAR(250),
            originalTitle VARCHAR(250)
          );
        ''';
       if(oldV<newV){
         db.execute(query);
       }
      })
    );
  }

  _createTables(Database db, int version) async{
    String query = '''CREATE TABLE tblPost (
      idPost INTEGER PRIMARY KEY,
      descripcion VARCHAR(200),
      date DATE
    );
    CREATE TABLE IF NOT EXISTS evento(
      idEvento INTEGER PRIMARY KEY,
      descripcion TEXT,
      fecha DATE,
      completado BOOLEAN
    )''';
    db.execute(query);
  }

  Future<int> insert(String tblName, Map<String,dynamic> data) async{
    var conexion = await database;
    return conexion.insert(tblName, data);
  }

  Future<int> deleteAll(String tblName) async {
    var conexion = await database;
    return conexion.delete(tblName);
  }

  Future<int> update(String tblName,Map<String,dynamic> data) async{
    var conexion = await database;
    return conexion.update(tblName,data,
    where: 'idPost = ?',
    whereArgs:[data['idPost']]);
  }

  Future<int> delete(String tblName, int idPost) async {
    var conexion = await database;
    return conexion.delete(tblName,
      where: 'idPost = ?',
      whereArgs: [idPost]);
  }

  Future<List<PostModel>> getPosts() async {
    var conexion = await database;
    var result = await conexion.query('tblPost');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  Future<List<EventModel>> getEvents() async {
    var conexion = await database;
    var result = await conexion.query('evento', orderBy: 'fecha DESC');
    return result.map((event) => EventModel.fromMap(event)).toList();
  }

  //Eventos para caleendario
    Future<List<EventModel>> getEventsPerDay(String date) async {
    var conexion = await database;
    var result = await conexion.query('evento',
                                  where: 'fecha=?',
                                  whereArgs: [date]);
    return result.map((event) => EventModel.fromMap(event)).toList();
  }

  Future<List<EventModel>> getEventsByDayRange(String firstDay, String lastDay) async {
    var conexion = await database;
    var result = await conexion.query('evento',
                                    where: 'fecha>=? AND fecha<=?',
                                    whereArgs: [firstDay,lastDay]);
    return result.map((event)=> EventModel.fromMap(event)).toList();
  }

  Future<int> deleteEvent(int idEvento) async{ 
    var conexion = await database;
    return conexion.delete('evento',
                          where: 'idEvento=?',
                          whereArgs: [idEvento]
    );
  }

  Future<List<EventModel>> getEventsByID(int idEvento) async {
    var conexion = await database;
    var result = await conexion.query('evento',
                                  where: 'idEvento=?',
                                  whereArgs: [idEvento]);
    return result.map((event) => EventModel.fromMap(event)).toList();
  }

  //Métodos que obtienen los datos de las peliculas favoritas
  Future<List<FavouriteModel>> getFavourites() async {
    var conexion = await database;
    var result = await conexion.query('favorito');
    return result.map((favourite) => FavouriteModel.fromMap(favourite)).toList();
  }

  Future<int> deleteFavourite(int favouriteID) async {
    var conexion = await database;
    return conexion.delete('favorito',
                          where: 'id=?',
                          whereArgs: [favouriteID]
    );
  }

}