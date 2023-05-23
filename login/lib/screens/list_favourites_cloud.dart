import 'package:flutter/material.dart';
import 'package:login/firebase/favourites_firebase.dart';
import 'package:login/widgets/item_favourite_firebase_widget.dart';

class ListFavouritesCloud extends StatefulWidget {
  const ListFavouritesCloud({super.key});

  @override
  State<ListFavouritesCloud> createState() => _ListFavouritesCloudState();
}

class _ListFavouritesCloudState extends State<ListFavouritesCloud> {

  FavouritesFirebase _ffavourites = FavouritesFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _ffavourites.getAllFavourites(),
        builder: ((context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                return Container(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text(snapshot.data!.docs[index].get('title')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(onPressed: (){
                            _ffavourites.insertFavourites({
                              'title': snapshot.data!.docs[index].get('title')
                            });
                          }, icon: const Icon(Icons.edit)),
                          IconButton(onPressed: (){
                            showDialog(
                              context: context, 
                              builder: (context) => AlertDialog(
                                title: const Text('Confirmar borrado'),
                                content: const Text('Borrar?'),
                                actions: [
                                  TextButton(
                                    onPressed: (){
                                      _ffavourites.deleteFavourite(snapshot.data!.docs[index].id);
                                      Navigator.pop(context);
                                    }, 
                                    child: const Text('Ok')
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    }, 
                                    child: const Text('Oknt')
                                  )
                                ],
                              )
                            );
                          }, icon: const Icon(Icons.delete))
                        ],
                      )
                    ],
                  ),
                );
              }
            );
          }else if(snapshot.hasError){
            return const Center(
              child: Text(
                'Error en la peticion'
              ),
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}