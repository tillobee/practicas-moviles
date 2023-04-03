import 'package:flutter/material.dart';
import 'package:login/models/movie_id_model.dart';
import 'package:login/models/popular_model.dart';
class ItemPopular extends StatelessWidget {
  /*Aqui se recibe la bandera y la información del modelo, para generar un objeto MovieID
    en el cual se carga la bandera*/
  const ItemPopular({super.key, required this.popularModel, required this.isFavourite});
  
  final PopularModel popularModel;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /* Se manda el objeto como parametro en la ruta nombrada y se cacha del otro lado para realizar la consulta al API de cada 
           pelicula de manera individual */
        Navigator.pushNamed(context, '/movie_detail',arguments: MovieID(id: popularModel.id, isFavourite: isFavourite));
      },
      child:Hero(
        tag: 'hero-${popularModel.id.toString()}',
        child: FadeInImage(
            fit: BoxFit.fill,
            placeholder: const AssetImage('assets/loading.gif'), 
            image: NetworkImage('https://image.tmdb.org/t/p/w500/${popularModel.posterPath}')
          ),
      ),
    );
  }
}

