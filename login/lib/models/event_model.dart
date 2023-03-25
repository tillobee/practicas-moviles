class EventModel {

  int? idEvento;
  String? descripcion;
  String? fecha;
  bool? completado;

  EventModel({
    this.idEvento,
    this.descripcion,
    this.fecha,
    this.completado
  });

  factory EventModel.fromMap(Map<String,dynamic> map){
    bool completed=false;

    (map['completado']==1)? completed=true:completed;

    /*Se clona el objeto del evento para poder sobreescribir el 
      completado como un BOOLEAN vez de un INT que nos devuelve la BD */
    final newMap = {
      ...map,
      'completado': completed
    };

    return EventModel(
      idEvento: map['idEvento'],
      descripcion: map['descripcion'],
      fecha: map['fecha'],
      completado: newMap['completado']
    );
  }
  
}