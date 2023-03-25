import 'package:flutter/material.dart';

class FlagsProvider with ChangeNotifier {
  bool _flagListPost = false;
  bool _flagReloadCalendar = false;

  getFlagListPost()=> this._flagListPost;

  setFlagListPost(){
    this._flagListPost=!_flagListPost;
    notifyListeners();
  }

  getFlagReloadCalendar()=> this._flagReloadCalendar;

  setFlagReloadCalendar(){
    this._flagReloadCalendar=!_flagReloadCalendar;
    notifyListeners();
  }
}