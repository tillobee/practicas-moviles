import 'package:flutter/material.dart';
import 'package:login/custom_page_route.dart';
import 'package:login/models/agent_model.dart';
import 'package:login/screens/agent_detail_screen.dart';

class ItemAgentWidget extends StatelessWidget {
  ItemAgentWidget({super.key, required this.agent});

  final AgentModel agent;

  double? iconsWidth;

  double? iconsHeight;

  @override
  Widget build(BuildContext context) {

    iconsHeight = MediaQuery.of(context).size.height/20;
    iconsWidth = MediaQuery.of(context).size.width/10;

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          CustomPageRoute(
            child: const AgentDetailScreen(), //se pueden mandar argumentos directamente en el constructor de la pantalla
            settings: RouteSettings(//pero tambien se pueden pasar en e objeto settings del Router
              arguments: agent
            )
          )
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Card(
          color: Color.fromARGB(255, 62, 62, 62),
          elevation: 20,
          semanticContainer: false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                )
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60), bottomRight: Radius.elliptical(50, 10)),
                      child: Image.network(agent.displayIcon!)
                    ),
              
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                        Text(agent.displayName!,style: const TextStyle(fontSize: 20,color: Colors.white),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(agent.role!.displayName!,style: const TextStyle(fontSize: 17, color: Colors.white),),
                            SizedBox(
                              width: iconsWidth,
                              height: iconsHeight,
                              child: Image.network(agent.role!.displayIcon!),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ...agent.abilities!.map((e) {
                                return (e.displayIcon!=null)? Image.network(e.displayIcon!,
                                  width:iconsWidth,
                                  height: iconsHeight
                                ):Container();
                              },)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}