import 'package:flutter/material.dart';
import 'package:login/models/agent_model.dart';

class AgentDetailScreen extends StatefulWidget {
  const AgentDetailScreen({super.key});

  @override
  State<AgentDetailScreen> createState() => _AgentDetailScreenState();
}

class _AgentDetailScreenState extends State<AgentDetailScreen> with TickerProviderStateMixin{

  List<Color>? _agentGradients;

  int cont=0;

  List<Animation<Offset>>? _rowAnimations;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500)
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller, 
    curve: Curves.linear
  );

  late final Animation<Offset> _bgAnimation = Tween<Offset>(
    begin: const Offset(0,-1.0),
    end: Offset.zero
  ).animate(_animation);

  late final Animation<Offset> _agAnimation = Tween<Offset>(
    begin: const Offset(-1.0,0.0),
    end: Offset.zero
  ).animate(_animation);

  late final Animation<Offset> _abAnimation = Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: Offset.zero
  ).animate(_animation);

  //ability 2 
  late final AnimationController _ability2Controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600)
  );

  late final Animation<double> _ability2Animation = CurvedAnimation(
    parent: _ability2Controller, 
    curve: Curves.linear
  );

  late final Animation<Offset> _ability2Final = Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: Offset.zero
  ).animate(_ability2Animation);

   //ability 3 
  late final AnimationController _ability3Controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700)
  );

  late final Animation<double> _ability3Animation = CurvedAnimation(
    parent: _ability3Controller, 
    curve: Curves.linear
  );

  late final Animation<Offset> _ability3Final = Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: Offset.zero
  ).animate(_ability3Animation);

   //ability 4 
  late final AnimationController _ability4Controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800)
  );

  late final Animation<double> _ability4Animation = CurvedAnimation(
    parent: _ability4Controller, 
    curve: Curves.linear
  );

  late final Animation<Offset> _ability4Final = Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: Offset.zero
  ).animate(_ability4Animation);

  //ability 5 
  late final AnimationController _ability5Controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900)
  );

  late final Animation<double> _ability5Animation = CurvedAnimation(
    parent: _ability5Controller, 
    curve: Curves.linear
  );

  late final Animation<Offset> _ability5Final = Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: Offset.zero
  ).animate(_ability5Animation);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      _controller.forward();
      _ability2Controller.forward();
      _ability3Controller.forward();
      _ability4Controller.forward();
      _ability5Controller.forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    
    final agent = ModalRoute.of(context)!.settings.arguments as AgentModel;
    _fillColors(agent.backgroundGradientColors!);

    return  Scaffold(
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.repeated,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: _agentGradients!
          )
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SlideTransition(
              position: _bgAnimation,
              child: SizedBox(
                width: deviceWidth,
                height: deviceHeight,
                child: Opacity(
                  opacity: 0.4,
                  child: Image.network(agent.background!,fit: BoxFit.scaleDown,)
                ),
              ),
            ),
            FadeTransition(//El contenedor opaco se envuelve en un fade transition para manejar la animación
              alwaysIncludeSemantics: true,
              opacity: _animation,
              child: Container(
                width: deviceWidth*0.85,
                height: deviceHeight*0.85,
                decoration: const BoxDecoration(
                  color:  Color.fromARGB(109, 158, 158, 158),
                  borderRadius:  BorderRadius.all(Radius.circular(15)),
                ),
                child: LayoutBuilder( //Construye unn stack que se ajusta al tamaño del contenedor opaco donde se muestran los datos del agente
                  builder: (context, constraint){
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          right: 5,
                          left: 5,
                          top: constraint.maxHeight/150,
                          child: SlideTransition(
                            position: _agAnimation,
                            child: Row( //Renglón que contiene el nombre y el icono del rol de agente
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(agent.displayName!,
                                  style: const TextStyle(
                                    letterSpacing: 5,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 40,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 20.0,
                                        offset: Offset(2.0, 2.0)
                                      )
                                    ]
                                  ),
                                ),
                                Image.network(agent.role!.displayIcon!,
                                  width: deviceWidth*0.125,
                                  height: deviceHeight*0.125
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right:25,
                          left: 25,
                          top: constraint.maxHeight*0.15,
                          child: Text(agent.description!,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize:15,
                              shadows: [
                                Shadow(
                                  blurRadius: 20.0,
                                  offset: Offset(2.0, 2.0)
                                ) 
                              ]
                            ),
                          )
                        ),
                        Positioned(
                          right: 5,
                          left: 5,
                          top: constraint.maxHeight/1.25,
                          child: (agent.abilities!.length==4)? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SlideTransition(
                                position: _abAnimation,
                                child: Image.network(agent.abilities![0].displayIcon!,
                                  width: deviceWidth*0.125,
                                  height: deviceHeight*0.125
                                ),
                              ),
                              SlideTransition(
                                position: _ability2Final,
                                child: Image.network(agent.abilities![1].displayIcon!,
                                  width: deviceWidth*0.125,
                                  height: deviceHeight*0.125
                                ),
                              ),
                              SlideTransition(
                                position: _ability3Final,
                                child: Image.network(agent.abilities![2].displayIcon!,
                                  width: deviceWidth*0.125,
                                  height: deviceHeight*0.125
                                ),
                              ),
                              SlideTransition(
                                position: _ability4Final,
                                child: Image.network(agent.abilities![3].displayIcon!,
                                  width: deviceWidth*0.125,
                                  height: deviceHeight*0.125
                                ),
                              )
                            ],
                          ):
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SlideTransition(
                                position: _abAnimation,
                                child: Image.network(agent.abilities![0].displayIcon!,
                                  width: deviceWidth*0.125,
                                  height: deviceHeight*0.125
                                ),
                              ),
                              SlideTransition(
                                position: _ability2Final,
                                child: Image.network(agent.abilities![1].displayIcon!,
                                  width: deviceWidth*0.125,
                                  height: deviceHeight*0.125
                                ),
                              ),
                              SlideTransition(
                                position: _ability3Final,
                                child: Image.network(agent.abilities![2].displayIcon!,
                                  width: deviceWidth*0.125,
                                  height: deviceHeight*0.125
                                ),
                              ),
                              SlideTransition(
                                position: _ability4Final,
                                child: Image.network(agent.abilities![3].displayIcon!,
                                  width: deviceWidth*0.125,
                                  height: deviceHeight*0.125
                                ),
                              ),
                              (agent.abilities![4].displayIcon!=null)?SlideTransition(
                                position: _ability5Final,
                                child: Image.network(agent.abilities![4].displayIcon!,
                                  width: deviceWidth*0.125,
                                  height: deviceHeight*0.125
                                ),
                              ):
                              Container()
                            ],
                          )
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: deviceHeight/40,
              left: 5,
              right: 5,
              child: SlideTransition(
                position: _agAnimation,
                child: Container(
                  width: deviceWidth,
                  height: deviceHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(agent.fullPortrait!)
                    )
                  ),
                ),
              ),
            ),
          ],
        )
      )
    );
  }

  Color _toColor(String hex){
    hex = hex.substring(0,6);
    if(hex.length==6){
      hex="FF"+hex;
    }
    if(hex.length==8){
      return Color(int.parse('0x$hex'));
    }return Colors.black;
  }

  _fillColors(List<String> colors){
    _agentGradients=[];
    for (var color in colors) {
      _agentGradients!.add(_toColor(color));
    }
  }
}