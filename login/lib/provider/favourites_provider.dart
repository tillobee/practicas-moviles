import 'package:flutter/material.dart';
import 'package:login/models/favourite_model.dart';

class FavouritesProvider extends ChangeNotifier {
  List<FavouriteModel> favourites=[];

  FavouritesProvider({
    required this.favourites
  });

  getFavouritesData() => this.favourites;

  setFavouritesData(FavouriteModel favourite){
    bool isIn=false;
    this.favourites.forEach((element) {
      if(element.id!=favourite.id){
        isIn=false;
      }else{
        isIn=true;
      }
    });
    if(isIn!=true){
      this.favourites.add(favourite);
    }
    notifyListeners();
  }

  removeFavouriteData(FavouriteModel favourite){
    this.favourites.removeWhere((fav) => fav.id==favourite.id);
    notifyListeners();
  }

  clearFavouritesData() {
    this.favourites=[];
    notifyListeners();
  } 

}