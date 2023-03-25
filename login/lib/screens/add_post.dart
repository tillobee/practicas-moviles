import 'package:flutter/material.dart';
import 'package:login/database/database_helper.dart';
import 'package:login/models/post_model.dart';
import 'package:login/provider/flags_provider.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  DatabaseHelper databaseHelper = DatabaseHelper();

  PostModel? objPostModel;

  @override
  Widget build(BuildContext context) {

    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    final txtContPost = TextEditingController();
    if(ModalRoute.of(context)!.settings.arguments!=null){
      objPostModel = ModalRoute.of(context)!.settings.arguments as PostModel;
      txtContPost.text=objPostModel!.descripcion!;
    }
        

    return Scaffold(
      body: Center(
        child: Container(
          margin:const EdgeInsets.all(10),
          padding:const EdgeInsets.all(15),
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
            border: Border.all(
              color: Colors.black
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              objPostModel == null ? const Text('add post'):  const Text('update post'),
              TextFormField(
                controller: txtContPost,
                maxLines: 8,
              ),
              ElevatedButton(
                onPressed:(() {
                  if(objPostModel==null){
                      databaseHelper.insert('tblPost', {
                      'descripcion' : txtContPost.text,
                      'date': DateTime.now().toString()
                    }).then((value) {
                      var msg = value > 0 ? 
                      'Registro insertado' : 
                      'Ocurrio un error';

                      var snackBar = SnackBar(
                        content: Text(msg)
                      );

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flag.setFlagListPost();
                    });
                  }else{
                    databaseHelper.update('tblPost', {
                      'idPost':objPostModel!.idPost,
                      'descripcion' : txtContPost.text,
                      'date': DateTime.now().toString()
                    }).then((value) {
                      var msg = value > 0 ? 
                      'Registro actualizado' : 
                      'Ocurrio un error';

                      var snackBar = SnackBar(
                        content: Text(msg)
                      );

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flag.setFlagListPost();
                    });
                  }
                }), 
                child: const Text('save post'))
            ],
          ),
        ),
      ),
    );
  }
}