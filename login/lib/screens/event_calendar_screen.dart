import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:login/database/database_helper.dart';
import 'package:login/models/event_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../provider/flags_provider.dart';


class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {

  DatabaseHelper? databaseHelper;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late DateTime _firstDay;
  late DateTime _lastDay;
  DateTime? _selectedDay;
  late Map<DateTime, List<EventModel>> _events;
  late List<EventModel> _list;
  Color? _colorEvent=Colors.purple;
  

  bool _calendarView =true; //bandera que indica el cambio de vista de calendario a lista
  Icon _selected = const Icon(Icons.calendar_month);

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode
    );
    _focusedDay=DateTime.now();
    _firstDay=_focusedDay.subtract(const Duration(days: 2000));
    _lastDay=_focusedDay.add(const Duration(days: 2000));
    _calendarFormat = CalendarFormat.month;
    _selectedDay = DateTime.now();
    databaseHelper = DatabaseHelper();
    _getEvents();
    _getAllEventsList();
  }

  @override
  Widget build(BuildContext context) {

    FlagsProvider flag=Provider.of<FlagsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de eventos'),
        actions: [
          IconButton(
            onPressed: (){
              _calendarView = !_calendarView;
              _calendarView ? _selected = Icon(Icons.calendar_month) : _selected = Icon(Icons.list);
              setState(() {});
            }, 
            icon: _selected
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.pushNamed(context, '/add_event').then((value){
            setState(() {
              _getEvents();
              _getAllEventsList();
            });
          });
        }, 
        label: const Text('Add event'),
        icon: const Icon(Icons.add_box)
      ),
      body: (_calendarView)? //A partir de la bandera muestra el calendario o la lista
        Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TableCalendar(
              focusedDay: _focusedDay, 
              firstDay: _firstDay, 
              lastDay: _lastDay,
              eventLoader: _getEventsPerDay,
              calendarFormat: _calendarFormat,
              calendarBuilders: CalendarBuilders(
                singleMarkerBuilder: (context, day, event) {

                  event = event as EventModel;
                  DateTime newDay=DateTime(day.year,day.month,day.day);
                  final hoursDiff=DateTime.now().difference(newDay).inHours;


                  if(hoursDiff<0 || hoursDiff<=-48){
                    _colorEvent=const Color.fromARGB(255, 215, 194, 11);
                  }else if(hoursDiff==0 || hoursDiff<=24){
                    _colorEvent=const Color.fromARGB(255, 18, 110, 21);
                  }else if(hoursDiff>24 && event.completado==true){
                    _colorEvent=const Color.fromARGB(255, 18, 110, 21);
                  }else if(hoursDiff>24){
                    _colorEvent=Colors.red;
                  }else{
                    _colorEvent=const Color.fromARGB(255, 196, 61, 220);
                  }

                  return Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: _colorEvent),
                    width: 7.0,
                    height: 7.0,
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  );
                },
                /* markerBuilder: (context, day, events) {
                  if(events.isNotEmpty){//excluye las casillas que no tienen eventos

                    DateTime newDay=DateTime(day.year,day.month,day.day);
                    final hoursDiff=DateTime.now().difference(newDay).inHours;

                    final todayEvent= events[0] as EventModel;//borrar si no jala

                    if(hoursDiff<0 || hoursDiff<=-48){
                      _colorEvent=const Color.fromARGB(255, 215, 194, 11);
                    }else if(hoursDiff==0 || hoursDiff<=24){
                      _colorEvent=const Color.fromARGB(255, 18, 110, 21);
                    }else if(hoursDiff>24 && todayEvent.completado==true){
                      _colorEvent=const Color.fromARGB(255, 18, 110, 21);
                    }if(hoursDiff>24){
                      _colorEvent=Colors.red;
                    }else{
                      _colorEvent=const Color.fromARGB(255, 196, 61, 220);
                    }

                    return Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: _colorEvent),
                      width: 7.0,
                      height: 7.0,
                      margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    );
                  } return null;
                }, */
              ),
              selectedDayPredicate: (day){
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
              final newSelectedDay = DateTime(selectedDay.year,selectedDay.month,selectedDay.day);
              _showDayEvents(_events[newSelectedDay]);
              print(_events[newSelectedDay]);
              if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
              if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            ElevatedButton(onPressed:()=>print(_list.toString()) , child: Text('eventos'))
          ],
        )
      ):
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context,index){

            final event = _list[index];

            DateTime eventDate = DateTime.parse(event.fecha!);
            DateTime todayDate = DateTime.now();
            final hoursDiff=todayDate.difference(eventDate).inHours;

            if(hoursDiff<0 || hoursDiff<=-48){
              _colorEvent=const Color.fromARGB(255, 215, 194, 11);
            }else if(hoursDiff==0 || hoursDiff<=24){
              _colorEvent=const Color.fromARGB(255, 18, 110, 21);
            }else if(hoursDiff>24 && event.completado==true){
              _colorEvent=const Color.fromARGB(255, 18, 110, 21);
            }else if(hoursDiff>24){
              _colorEvent=Colors.red;
            }else{
              _colorEvent=const Color.fromARGB(255, 196, 61, 220);
            }

            

            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                height:100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _colorEvent,
                  border: Border.all(
                    color: Colors.black
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(event.descripcion!),
                        Text(event.fecha!)
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: (){
                        showDialog(
                          context: context, 
                          builder: (context) => AlertDialog(
                            title: const Text('Confirmar borrado'),
                            content: const Text('¿TAS SEGURO?'),
                            actions: [
                              ElevatedButton(
                                onPressed: (){
                                  databaseHelper!.deleteEvent(event.idEvento!).then((value){
                                    setState(() {
                                      _getEvents();
                                      _getAllEventsList();
                                    });
                                  });
                                  Navigator.pop(context);
                                }, 
                                child: Text('osiosiiii')
                              ),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                }, 
                                child: Text('nel pa')
                              )
                            ],
                          )
                        );
                      }, 
                      icon: const Icon(Icons.delete_forever)
                    ),
                    IconButton(
                      onPressed: (){
                        _showEventDetails(event.idEvento!);
                      }, 
                      icon: const Icon(Icons.search)
                    ),
                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(Icons.refresh)
                    )
                  ],
                ),
              ),
            );
          }),
      )
    );
  }

  _getEvents(){ //genera un mapa de diaas y las listas de eventos correspondientes para ese dia
    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    _events = {};

    Future events =databaseHelper!.getEventsByDayRange(firstDay.toString(),lastDay.toString());

    events.then((data) {
     for (var element in data) {
       final EventModel event = element;
       final date = DateTime.parse(event.fecha!);
       final day = DateTime(date.year,date.month,date.day);
       if(_events[day]==null){
        _events[day]=[];
       }
       _events[day]!.add(event);
     }

     setState(() {});
    },onError: (e)=>print(e)
    );
  }

  List<EventModel> _getEventsPerDay(DateTime day){ //Devuelve una lista de eventos a partir del dia dado para llenar el calendario con los eventos
    final newDay = DateTime(day.year,day.month,day.day);
    return _events[newDay] ?? [];
  }

  _getAllEventsList(){ //Llena la lista de todos los eventos para mostrarlas en el ListView
    _list=[];
    Future events = databaseHelper!.getEvents();
    events.then((data){
      for (var event in data) {
        _list.add(event);
      }
    },
    onError: (e)=>print(e)
    );
  }

  _getListE(){//Llena la lista de todos los eventos a partir del mapa de eventos (No puchona creo unu)
    _list=[];
    _events.forEach((key, value) { 
      _list.addAll(value);
    });
  }
  
  //Muestra un dialogo con los eventos de cada dia al seleccionar un DIA en el calendario, si ese dia no tiene eventos se muestra otro dialogo diciendo que no hay na
  _showDayEvents(List<EventModel>? dayEvents){  
    dayEvents!=null?
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Eventos del dia'),
        actions: [
          SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height /3,
            child: ListView(
              children: [
                ...dayEvents.map(
                    (event) => ListTile(
                      leading: const Icon(Icons.calendar_month_outlined),
                      trailing: const Icon(Icons.chevron_right),
                      title: Text(event.descripcion!),
                      subtitle: Text(event.fecha!),
                      onTap: (){
                        _showEventDetails(event.idEvento!);
                      },
                    )
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: ()=>Navigator.pop(context), 
            child: const Text('oki')
          )
        ],
      )
    ):
    showDialog(
      context: context, 
      builder: (context)=>AlertDialog(
        title: const Text('Eventos del dia'),
        content: const Text('No hay eventos hoy...'),
        actions: [
          ElevatedButton(
            onPressed: ()=>Navigator.pop(context), 
            child: const Text('oki')
          )
        ],
      )
    );
  }

  _showEventDetails(int idEvento){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('Detalles del evento'),
        actions: [
          SizedBox(
            height: MediaQuery.of(context).size.height/3,
            width: double.infinity,
            child: FutureBuilder( //Future builder para generar el contenedor a partir del resultado de la petición
              future: databaseHelper!.getEventsByID(idEvento),
              builder: (context, AsyncSnapshot<List<EventModel>> snapshot){
                if(snapshot.hasData){
                  String completado;
                  final eventData = snapshot.data![0]; //se asigna la posición 0 pq al ser una busqueda por ID solo obtenemos un resultado
                  (eventData.completado!)? completado='Completado': completado='No completado';
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(eventData.descripcion!),
                      Text(eventData.fecha!),
                      Text(completado),
                    ],
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
              }),
          ),
          ElevatedButton(
            onPressed: ()=>Navigator.pop(context), 
            child: const Text('okis'))
        ],
      )
    );

  }
}