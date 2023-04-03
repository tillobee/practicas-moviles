import 'package:flutter/material.dart';
import 'package:login/models/favourite_model.dart';
import 'package:login/models/movie_id_model.dart';

class ItemFavouriteMovie extends StatelessWidget {
  const ItemFavouriteMovie({super.key, required this.favourite});

  final FavouriteModel favourite;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/movie_detail',arguments: MovieID(id: favourite.id, isFavourite: true));
      },
      child:FadeInImage(
          fit: BoxFit.fill,
          placeholder: const AssetImage('assets/loading.gif'), 
          image: NetworkImage('https://image.tmdb.org/t/p/w500/${favourite.posterPath}')
        ),
    );
  }
}
