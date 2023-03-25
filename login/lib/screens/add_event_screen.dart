import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/database/database_helper.dart';
import 'package:provider/provider.dart';

import '../provider/flags_provider.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}


class _AddEventScreenState extends State<AddEventScreen> {

  DatabaseHelper databaseHelper = DatabaseHelper();

  final spaceH = const SizedBox(
    height: 20,
  );

  final txtDesc = TextEditingController();

  DateTime selectedDate = DateTime.now();

  bool completed = false;

  @override
  Widget build(BuildContext context) {

    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Scaffold(
      body: Center(
        child: Container(
          margin:const EdgeInsets.all(10),
          padding:const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(239, 147, 255, 151),
            border: Border.all(
              color: Colors.black
            )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Add event'),
              spaceH,
              TextField(
                decoration: const InputDecoration(
                  label: Text('Descripción'),
                  border: OutlineInputBorder()
                ),
                controller: txtDesc,
                maxLines: 4,
              ),
              spaceH,
              const Text('Fecha del evento'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){
                      _selectDate(context);
                    }, 
                    icon: const Icon(Icons.calendar_month)
                  ),
                  Text('${selectedDate.year}/${selectedDate.month}/${selectedDate.day}')
                ],
              ),
              spaceH,
              const Text('¿Evento completado?'),
              Switch(
                value: completed, 
                activeColor: Colors.red,
                onChanged: ((value) {
                  setState(() {
                    completed=value;
                  });
                })
              ),
              ElevatedButton(
                onPressed: (){
                  
                  String shortDate = DateFormat('yyyy-MM-dd').format(selectedDate);

                  Map<String,dynamic> eventData = {
                    'descripcion':txtDesc.text,
                    'fecha':shortDate,
                    'completado':completed.toString()
                  };

                  databaseHelper.insert('evento',eventData).then((value) {
                     var msg = value > 0 ? 
                    'Registro insertado' : 
                    'Ocurrio un error';

                    var snackBar = SnackBar(
                      content: Text(msg)
                    );

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //cambiar bandera para hacer un setState con el Provider?
                    flag.setFlagReloadCalendar();
                  });
                }, 
                child: const Text('save event')
              )
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context, 
      initialDate: selectedDate, 
      firstDate: DateTime(2023), 
      lastDate: DateTime(2070)
    );

    if(selected == null) return;
    setState(() {
      selectedDate=selected;
    });
  }
}