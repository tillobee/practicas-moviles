import 'package:flutter/material.dart';
import 'package:login/database/database_helper.dart';
import 'package:login/models/favourite_model.dart';
import 'package:login/provider/favourites_provider.dart';
import 'package:login/widgets/item_favourite_movie_widget.dart';
import 'package:provider/provider.dart';

class ListFavouriteMoviesScreen extends StatefulWidget {
  const ListFavouriteMoviesScreen({super.key});

  @override
  State<ListFavouriteMoviesScreen> createState() => _ListFavouriteMoviesScreenState();
}

class _ListFavouriteMoviesScreenState extends State<ListFavouriteMoviesScreen> {

  DatabaseHelper? databaseHelper;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseHelper= DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {

    final favsProvider = context.watch<FavouritesProvider>();
    final List<FavouriteModel> favsList = favsProvider.getFavouritesData();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite list'),
        actions: [
          IconButton(
            onPressed: (){
              databaseHelper!.deleteAll('favorito');
              favsProvider.clearFavouritesData();
            }, 
            icon: const Icon(Icons.delete)
          ),
          IconButton(
            onPressed: (){
              _getFavourites();
            }, 
            icon: const Icon(Icons.favorite)
          ) ,
          IconButton(
            onPressed: (){
              for (var element in favsList) {
                FavouriteModel fav = element;
                print('${fav.id} - ${fav.originalTitle} - ${fav.posterPath}');
              }
            }, 
            icon: const Icon(Icons.favorite_border_outlined)
          ) 
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .9,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10
          ),
          itemCount: favsList.length,
          itemBuilder: (context, index) {
            final fav = favsList[index];
            return ItemFavouriteMovie(favourite:fav) ;
          },
        ),
      )
    );
  }

  _getFavourites(){
    Future result = databaseHelper!.getFavourites();
    result.then((data){
      List<FavouriteModel> favourites = data;
      for (var favourite in favourites) {
        FavouriteModel fav = favourite;
        print('${fav.id} - ${fav.originalTitle} - ${fav.posterPath}');
      }
    });
  }
}