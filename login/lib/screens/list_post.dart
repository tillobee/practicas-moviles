import 'package:flutter/material.dart';
import 'package:login/database/database_helper.dart';
import 'package:login/provider/flags_provider.dart';
import 'package:login/widgets/item_post_widget.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';

class ListPost extends StatefulWidget {
  const ListPost({super.key});

  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {

  DatabaseHelper? database;

  @override
  void initState() { //INICIALIZA VARIABLES ANTES DE CUALQUIER COSA
    // TODO: implement initState
    super.initState();
    database = DatabaseHelper(); //Se asegura de que la instacia esta creada antes de que se renderize la interfaz
  }

  @override
  Widget build(BuildContext context) {

    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return FutureBuilder(
      future: flag.getFlagListPost()==true ? database!.getPosts() : database!.getPosts() ,
      builder:(context, AsyncSnapshot<List<PostModel>> snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objPostModel = snapshot.data![index];
              return ItemPostWidget(objPostModel: objPostModel);
            },
          );
        }else if(snapshot.hasError){
          return const Center(
            child: Text('Ocurrió un error'),
          );
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}