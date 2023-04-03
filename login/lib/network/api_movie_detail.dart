import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login/models/movie_detail_model.dart';

class ApiMovieDetail {
  Future<MovieDetailModel?> getMovieDetail(int id) async {
    Uri link = Uri.parse('https://api.themoviedb.org/3/movie/${id.toString()}?api_key=0cb894064f40656f3575e8ccae3d8d73&append_to_response=videos,credits');
    var result= await http.get(link);
    var JSON=jsonDecode(result.body);
    if(result.statusCode==200){
      return MovieDetailModel.fromMap(JSON);
    }
    return null;
  }
}