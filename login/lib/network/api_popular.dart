import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login/models/popular_model.dart';

class ApiPopular {
  Uri link = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=0cb894064f40656f3575e8ccae3d8d73&language=es-MX&page=1');
  Future<List<PopularModel>?> getAllPopular() async {
    var result= await http.get(link);
    var listJSON=jsonDecode(result.body)['results'] as List;
    if(result.statusCode==200){
      //si
      return listJSON.map((popular) => PopularModel.fromMap(popular)).toList();
    }
    return null;
  }
}