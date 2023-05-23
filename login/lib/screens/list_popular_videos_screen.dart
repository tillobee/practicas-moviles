import 'package:flutter/material.dart';
import 'package:login/database/database_helper.dart';
import 'package:login/models/favourite_model.dart';
import 'package:login/models/popular_model.dart';
import 'package:login/network/api_popular.dart';
import 'package:login/provider/favourites_provider.dart';
import 'package:login/widgets/item_popular_widget.dart';
import 'package:provider/provider.dart';

class ListPopularVideosScreen extends StatefulWidget {
  const ListPopularVideosScreen({super.key});

  @override
  State<ListPopularVideosScreen> createState() => _ListPopularVideosScreenState();
}

class _ListPopularVideosScreenState extends State<ListPopularVideosScreen> {
  
  ApiPopular? apiPopular;
  List<FavouriteModel>? _favourites;
  DatabaseHelper? databaseHelper;
  List<PopularModel>? loadingPopular=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular=ApiPopular();
    databaseHelper = DatabaseHelper();
    loadingPopular!.add(
      PopularModel.fromMap({
        'id': 0,
      'backdrop_path': '/kUAG4ZQcsNbRyiPyAr3hLdsVgAq.jpg',
      'original_language': 'loading',
      'original_title':'loading',
      'overview': 'loading',
      'popularity': 0.0,
      'poster_path': '/kUAG4ZQcsNbRyiPyAr3hLdsVgAq.jpg',
      'release_date': '01/01/1888',
      'title': 'loading',
      'vote_average':0.0,
      'vote_count': 0
      })
    );
  }
  
  @override
  Widget build(BuildContext context) {

    final favouritesProvider = context.watch<FavouritesProvider>();
    _favourites = favouritesProvider.getFavouritesData();//Primera vez que se llama a favouriteProvider????

    return Scaffold(
      appBar: AppBar(
        title: const Text('List popular'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/favourite_movies');
            },
            icon: const Icon(Icons.list)
          )
        ],
      ),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(),
        /* initialData: loadingPopular, */
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
          if(snapshot.hasData){
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .9,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10
              ),
              itemCount: snapshot.data != null ?snapshot.data!.length:0,
              itemBuilder: (context, index){
                /*En initState se hace la consulta de la lista de favoritos y se recorre aqui para 
                  determinar si la pelicula esta marcada como favorita, y se agrega una bandera a cada item 
                  dentro del grid para heredarla hasta el detalle */
                bool isFav=false;
                PopularModel popular = snapshot.data![index];
                if(_favourites!.isNotEmpty){ //siempre y cuando no este vacío
                  for (var favourite in _favourites!) {
                    FavouriteModel fav = favourite;
                    if(popular.id==fav.id){
                      isFav=true;
                    }
                  }
                }
                return ItemPopular(popularModel: snapshot.data![index], isFavourite: isFav,);
              }
            );
          }else if(snapshot.hasError){
            return const Center(
              child: Text('Error alv'),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator()
            );
          }
        }
      )
    );
  }


 /*  _getFavouriteIDs(){
    _favouriteIDs=[];
    Future result = databaseHelper!.getFavourites();
    result.then((data) {
      List<FavouriteModel> favourites = data;
      for (var favourite in favourites) {
        FavouriteModel fav = favourite;
        _favouriteIDs!.add(fav.id!);
      }
    });
  }  */
}