import 'package:flutter/material.dart';
import 'package:login/database/database_helper.dart';
import 'package:login/models/movie_detail_model.dart';
import 'package:login/models/movie_id_model.dart';
import 'package:login/network/api_movie_detail.dart';
import 'package:login/widgets/item_movie_detail_widget.dart';
import 'package:login/widgets/item_popular_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}


class _MovieDetailScreenState extends State<MovieDetailScreen> {

  DatabaseHelper? databaseHelper;


  MovieID? moviePopularData;
  ApiMovieDetail? apiMovieDetail;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiMovieDetail = ApiMovieDetail();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {

    /* Se reciben los parametros en la nueva pantalla */
    if(ModalRoute.of(context)!.settings.arguments!=null){
      moviePopularData=ModalRoute.of(context)!.settings.arguments as MovieID;
    }

    return Scaffold(
      body: FutureBuilder(
        /* Se genera un futureBuilder a partir de la petición a la API mandando como parámetro el ID de a pelicula */
        future: apiMovieDetail!.getMovieDetail(moviePopularData!.id!),
        builder: (context, AsyncSnapshot<MovieDetailModel?> snapshot){
          if(snapshot.hasData){
            final movieDetail = snapshot.data;
            /* Se mandan los datos que se reciben de la petición como parámetros nombrados al widget qye muestra toda la información de cada pelicula
              junto con la bandera de favorito para marcarla en pantalla */
            return ItemMovieDetail(movieDetail: movieDetail!, isFavourite: moviePopularData!.isFavourite!);
          }else if(snapshot.hasError){
            return const Center(
              child: Text('Ocurrió un error'),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )      
    );
  }

}