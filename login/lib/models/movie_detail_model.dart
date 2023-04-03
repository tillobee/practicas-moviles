class MovieDetailModel{
  String? backdropPath;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? tagline;
  String? title;
  double? voteAverage;
  int? voteCount;
  List<Videos>? videos;
  List<Credits>? credits; 

  MovieDetailModel({
      this.backdropPath,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.tagline,
      this.title,
      this.voteAverage,
      this.voteCount,
      this.videos,
      this.credits
    }
  );

  factory MovieDetailModel.fromMap(Map<String,dynamic> map){
    final listVideos =<Videos>[];
    final listCast = <Credits>[];

    if(map['videos']['results']!=null){
      map['videos']['results'].forEach((v){
        final vid = Videos.fromMap(v);
        if(vid.type=='Trailer'){
          listVideos.add(Videos.fromMap(v));
        }
      });   
    }

    if(map['credits']['cast']!=null){
      map['credits']['cast'].forEach((v){
        listCast.add(Credits.fromMap(v));
      });   
    }

    return MovieDetailModel(
      backdropPath: map['backdrop_path'],
      id: map['id'],
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      posterPath: map['poster_path'],
      releaseDate: map['release_date'],
      tagline: map['tagline'],
      title: map['title'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
      videos: listVideos,
      credits: listCast,
    );
  }
  
}

class Videos {
  String? name;
  String? key;
  String? site;
  String? type;
  bool? official;

  Videos({
    this.name,
    this.key,
    this.site,
    this.type,
    this.official,
  });

  factory Videos.fromMap(Map<String,dynamic> map){
    return Videos(
      name: map['name'],
      key: map['key'],
      site: map['site'],
      type: map['type'],
      official: map['official'],
    );
  }
  
}

class Credits {
  int? gender;
  int? id;
  String? name;
  String? profilePath;
  String? character;

  Credits({
    this.gender,
    this.id,
    this.name,
    this.profilePath,
    this.character
  });

  factory Credits.fromMap(Map<String,dynamic> map){
    return Credits(
      gender: map['gender'],
      id: map['id'],
      name: map['name'],
      profilePath: map['profile_path'],
      character: map['character'],
    );
  }

}