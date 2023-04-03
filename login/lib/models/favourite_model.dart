class FavouriteModel {
  int? id;
  String? posterPath;
  String? originalTitle;

  FavouriteModel({
    this.id,
    this.posterPath,
    this.originalTitle
  });

  factory FavouriteModel.fromMap(Map<String, dynamic> map){
    return FavouriteModel(
      id: map['id'],
      posterPath: map['posterPath'],
      originalTitle: map['originalTitle']
    );
  }

}