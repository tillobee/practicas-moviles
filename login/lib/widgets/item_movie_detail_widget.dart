import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login/database/database_helper.dart';
import 'package:login/models/favourite_model.dart';
import 'package:login/models/movie_detail_model.dart';
import 'package:login/provider/favourites_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ItemMovieDetail extends StatefulWidget {
  /* Se reciben los datos de la petición en el widget y la bandera para determinar el estado de la marca */
  const ItemMovieDetail({super.key, required this.movieDetail, required this.isFavourite});

  final MovieDetailModel movieDetail;
  final bool isFavourite;

  @override
  State<ItemMovieDetail> createState() => _ItemMovieDetailState();
}

class _ItemMovieDetailState extends State<ItemMovieDetail> {

  DatabaseHelper? databaseHelper;

  bool? isTrailerAvailable;
  double? _popPercent, _popPercentIndicator;
  Icon _heartIcon= const Icon(Icons.favorite_border_outlined);
  bool _markedFavourite = false; 
  
  late YoutubePlayerController controller;

  final spaceH = const SizedBox(
    height: 10,
  );

  @override
  void initState() {
    super.initState();

    databaseHelper = DatabaseHelper();

    final String url;
    _markedFavourite=widget.isFavourite;
    (_markedFavourite)? _heartIcon = const Icon(Icons.favorite, color: Colors.red,):_heartIcon = const Icon(Icons.favorite_border);

    if(widget.movieDetail.videos!.isEmpty){
      url  = 'https://www.youtube.com/watch?v=c21QZnQtGqo';
    }else{
      final videoKey = widget.movieDetail.videos![0].key;
      url  = 'https://www.youtube.com/watch?v=${videoKey!}';
    }

    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
       autoPlay: false
      )
    );

    _popPercentIndicator = widget.movieDetail.voteAverage!*10;//Desplaza el punto decimal una posicion hacia la izquierda para mostrar el % en un texto alv
    _popPercentIndicator = double.parse(_popPercentIndicator!.toStringAsFixed(2));
    _popPercent = widget.movieDetail.voteAverage!/10;  //Recorre el punto decimal una posicion hacia la derecha para indicar el % en el widget
  }
  
  @override
  Widget build(BuildContext context) {

    final favouritesProvider = context.watch<FavouritesProvider>();
    
    //Aqui se diseña el contenedor a partir de la información que viene del future builder
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieDetail.originalTitle!),
        actions: [
          IconButton(
            onPressed: (){
              _markedFavourite = !_markedFavourite;
              if(_markedFavourite){
                _heartIcon = const Icon(Icons.favorite, color: Colors.red,);
                databaseHelper!.insert('favorito', {
                  'id':widget.movieDetail.id,
                  'posterPath':widget.movieDetail.posterPath,
                  'originalTitle':widget.movieDetail.originalTitle
                  }
                ).then((value) {

                  var msg = value > 0 ? 
                  'Registro actualizado' : 
                  'Ocurrio un error';

                  var snackBar = SnackBar(
                    content: Text(msg)
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
                setState(() {
                  favouritesProvider.setFavouritesData(
                    FavouriteModel(
                      id:widget.movieDetail.id, 
                      posterPath: widget.movieDetail.posterPath,
                      originalTitle: widget.movieDetail.originalTitle
                    )
                  );
                });
              }else{
                _heartIcon = const Icon(Icons.favorite_outline);
                databaseHelper!.deleteFavourite(widget.movieDetail.id!)
                .then((value) {
                   var msg = value > 0 ? 
                  'Registro actualizado' : 
                  'Ocurrio un error';

                  var snackBar = SnackBar(
                    content: Text(msg)
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
                setState(() {
                  favouritesProvider.removeFavouriteData(
                    FavouriteModel(
                      id:widget.movieDetail.id, 
                      posterPath: widget.movieDetail.posterPath,
                      originalTitle: widget.movieDetail.originalTitle
                    )
                  );
                });
              }
            }, 
            icon: _heartIcon)
        ],
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
        ), 
        builder: (context, player){
          return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network('https://image.tmdb.org/t/p/w500/${widget.movieDetail.posterPath}').image,
                  opacity: .4,
                  fit: BoxFit.cover
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2.5,
                        height: 200,
                        child: Hero(
                          tag: 'hero-${widget.movieDetail.id}',
                          child: FadeInImage(
                            fit: BoxFit.fill,
                            placeholder: const AssetImage('assets/loading.gif'), 
                            image: NetworkImage('https://image.tmdb.org/t/p/w500/${widget.movieDetail.posterPath}')
                          ),
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 50,
                        lineWidth: 10,
                        percent: _popPercent!,
                        center: Text('${_popPercentIndicator!.toString()}%'),
                        header: const Text('Popularity'),
                        progressColor: Colors.purple,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(158, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(98, 0, 0, 0),
                          blurRadius: 25,
                          offset: Offset(0, 2)
                        )
                      ]
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Text(widget.movieDetail.overview!, textAlign: TextAlign.center,)
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 25,
                          offset: Offset(0, 2)
                        )
                      ]
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: player,
                  ),
                  RatingBarIndicator(
                    rating: widget.movieDetail.voteAverage! ,
                    direction: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    itemPadding: const EdgeInsets.all(4.0),
                    itemSize: 25,
                    itemBuilder: (context,_)=> const Icon(Icons.star, color: Color.fromARGB(255, 255, 231, 20),), 
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.movieDetail.credits!.length ,
                      itemBuilder: (context, index){
                        final actor = widget.movieDetail.credits![index];
                  
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.purple,
                                radius: 50,
                                child: ClipOval(
                                  child: (actor.profilePath != null)? 
                                      Image.network('https://image.tmdb.org/t/p/w500/${actor.profilePath}',
                                        fit: BoxFit.fill, 
                                        width: 90,
                                        height: 90,
                                      ):
                                      const Image(image: AssetImage('assets/no_image.jpg')),
                                ),
                              ),
                              Text(actor.name!,
                                overflow: TextOverflow.clip,
                              )
                            ],
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
          );
        }
      )
    );  
  }
}