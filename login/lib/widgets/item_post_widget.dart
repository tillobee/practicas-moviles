import 'package:flutter/material.dart';
import 'package:login/database/database_helper.dart';
import 'package:login/models/post_model.dart';
import 'package:provider/provider.dart';

import '../provider/flags_provider.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key, this.objPostModel});

  PostModel? objPostModel;

  DatabaseHelper databaseHelper = DatabaseHelper();

  
  @override
  Widget build(BuildContext context) {


    FlagsProvider flag = Provider.of<FlagsProvider>(context);


    final avatar = CircleAvatar(
      backgroundImage: AssetImage('assets/no_image.jpg'),
    );

    final txtUser = Text('Si');

    final datePost = Text('06/03/2023');
    final imgPost = Image(image: AssetImage('assets/logo.png'));
    final txtDesc = Text(objPostModel!.descripcion!);
    final iconRate = Icon(Icons.star);


    return Container(
      margin: const EdgeInsets.all(10),
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Row(
            children: [
              avatar,
              txtUser,
              datePost
            ],
          ),
          Row(
            children: [
              imgPost,
              txtDesc
            ],
          ),
          Row(
            children: [
              iconRate,
              IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/add', arguments:objPostModel);
                }, 
                icon: const Icon(Icons.edit)
              ),
              Expanded(
                child: Container()
              ),
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar borrado'),
                      content: const Text('Borrar?'),
                      actions: [
                        TextButton(
                          onPressed: (){
                            databaseHelper.delete('tblPost', objPostModel!.idPost!).then(
                              (value) => flag.setFlagListPost()
                            );
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

                }, 
                icon:const Icon(Icons.delete)
              )
            ],
          )
        ],
      ),
    );
  }
}