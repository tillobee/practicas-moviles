import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:login/models/agent_model.dart';
import 'package:login/network/api_valorant.dart';
import 'package:login/widgets/item_agent_widget.dart';

class ListAgentsScreen extends StatefulWidget {
  const ListAgentsScreen({super.key});

  @override
  State<ListAgentsScreen> createState() => _ListAgentsScreenState();
}

class _ListAgentsScreenState extends State<ListAgentsScreen> {

  double? iconsWidth;
  double? iconsHeight;
  ApiValorant? valoncho;

  List<String>? _colorKeys=[];
  List<Color>? _colors;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _colorKeys!.addAll(<String>[
      '#000000',
      '#FD4556',
      '#BD3944',
      '#53212B',
      '#FFFBF5',
      ]);
    _fillColors(_colorKeys!);
    valoncho=ApiValorant();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/valorant_vertical_n.png'),
        ),
        gradient: LinearGradient(
          tileMode: TileMode.repeated,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: _colors!
        )
      ),
      child: FutureBuilder(
        future: valoncho!.getAgents() ,
        builder: (context, AsyncSnapshot<List<AgentModel>?> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: (snapshot.data!.isEmpty)?0:snapshot.data!.length,
              itemBuilder: (context, index){
                AgentModel agent = snapshot.data![index];
                return ItemAgentWidget(agent:agent);
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
        } ,
      )
    );
  }


  Color _toColor(String hex){
    hex=hex.replaceAll("#", "");
    if(hex.length==6){
      hex="FF"+hex;
    }
    if(hex.length==8){
      return Color(int.parse('0x$hex'));
    }
    return Colors.black;
  } 

  _fillColors(List<String> colors){
    _colors=[];
    for (var color in colors) {
      _colors!.add(_toColor(color));
    }
  }
}