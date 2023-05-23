import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemFavouriteFirebase extends StatefulWidget {
  ItemFavouriteFirebase({super.key, required this.ffirebase});

  QueryDocumentSnapshot ffirebase;

  @override
  State<ItemFavouriteFirebase> createState() => _ItemFavouriteFirebaseState();
}

class _ItemFavouriteFirebaseState extends State<ItemFavouriteFirebase> {
  @override
  Widget build(BuildContext context) {
    return Card(
     child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.network(widget.ffirebase.get('poster_path')),
        Text(widget.ffirebase.get('title')),
        IconButton(
          onPressed: (){

          }, 
          icon: const Icon(Icons.delete)
        ),
        IconButton(
          onPressed: (){

          }, 
          icon: const Icon(Icons.update)
        )
      ],
     ),
    );
  }
}