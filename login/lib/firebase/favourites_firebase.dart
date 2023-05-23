import 'package:cloud_firestore/cloud_firestore.dart';

class FavouritesFirebase {
  FirebaseFirestore _firebase = FirebaseFirestore.instance;
  CollectionReference? _favouritesCollection;

  FavouritesFirebase(){
    _favouritesCollection = _firebase.collection('favourites');
  }

  Future<void> insertFavourites(Map<String, dynamic> map) async {
    return _favouritesCollection!.doc().set(map);
  }

  Future<void> updateFavourites(Map<String,dynamic> map, String id) async {
    return _favouritesCollection!.doc(id).update(map);
  }

   Future<void> deleteFavourite(String id) async {
    return _favouritesCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllFavourites() {
    return _favouritesCollection!.snapshots();
  }
}