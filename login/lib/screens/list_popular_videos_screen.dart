import 'package:flutter/material.dart';
import 'package:login/models/popular_model.dart';
import 'package:login/network/api_popular.dart';
import 'package:login/widgets/item_popular_widget.dart';

class ListPopularVideosScreen extends StatefulWidget {
  const ListPopularVideosScreen({super.key});

  @override
  State<ListPopularVideosScreen> createState() => _ListPopularVideosScreenState();
}

class _ListPopularVideosScreenState extends State<ListPopularVideosScreen> {
  
  ApiPopular? apiPopular;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular=ApiPopular();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List popular'),
      ),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(),
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
                return ItemPopular(popularModel: snapshot.data![index]);
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
}