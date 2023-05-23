import 'package:flutter/material.dart';
import 'package:login/screens/add_event_screen.dart';
import 'package:login/screens/add_post.dart';
import 'package:login/screens/custom_theme_screen.dart';
import 'package:login/screens/dashboard_screen.dart';
import 'package:login/screens/event_calendar_screen.dart';
import 'package:login/screens/list_agents_agents.dart';
import 'package:login/screens/list_favourite_movies_screen.dart';
import 'package:login/screens/list_favourites_cloud.dart';
import 'package:login/screens/list_popular_videos_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/movie_detail_screen.dart';
import 'package:login/screens/register_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String,WidgetBuilder>{
    '/register':(BuildContext context) => const RegisterScreen(),
    '/dash':(BuildContext context) =>  DashboardScreen(),
    '/custom_theme':(BuildContext context) => const CustomThemeScreen(),
    '/home':(BuildContext context)=> LoginScreen(),
    '/add':(BuildContext context) => AddPostScreen(),
    '/event_calendar':(BuildContext context) => EventCalendarScreen(),
    '/add_event':(BuildContext context) => AddEventScreen(),
    '/si':(BuildContext context) =>EventCalendarScreen(),
    '/popular_videos':(BuildContext context) => ListPopularVideosScreen(),
    '/movie_detail':(BuildContext context) => MovieDetailScreen(),
    '/favourite_movies':(BuildContext context) => ListFavouriteMoviesScreen(),
    '/list_agents':(BuildContext context, ) => ListAgentsScreen(),
    '/favourites_cloud':(BuildContext context, ) => ListFavouritesCloud(),
    '/maps':(BuildContext context, ) => ListFavouritesCloud(),

  };  
}