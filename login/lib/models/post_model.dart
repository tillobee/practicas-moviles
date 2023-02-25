class PostModel {
  int? idPost;
  String? descripcion;
  String? date;

  PostModel(
    {
    this.idPost,
    this.descripcion,
    this.date
    }
  );

  factory PostModel.fromMap(Map<String,dynamic> map){
    return PostModel(
      idPost: map['idPost'],
      descripcion: map['descripcion'],
      date: map['date']
    );
  }
}