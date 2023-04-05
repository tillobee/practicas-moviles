import 'dart:ffi';

import 'package:flutter/material.dart';

class AgentModel{

  String? displayName;
  String? description;
  String? displayIcon;
  String? fullPortrait;
  String? background;
  List<String>? backgroundGradientColors;
  Role? role;
  List<Abilities>? abilities;

  AgentModel({
    this.displayName,
    this.description,
    this.displayIcon,
    this.fullPortrait,
    this.background,
    this.backgroundGradientColors,
    this.role,
    this.abilities
  });

  factory AgentModel.fromMap(Map<String,dynamic> map){

    final Role role;
    final abilitiesList=<Abilities>[];
    final colorsList = <String>[];

    if(map['role']!=null){
       role = Role(
        displayName: map['role']['displayName'], 
        displayIcon: map['role']['displayIcon']
      );
    } else{
      role=Role();
    }
    
    if(map['abilities']!=null){
      map['abilities'].forEach((a){
        abilitiesList.add(Abilities.fromMap(a));
      });
    }

    if(map['backgroundGradientColors']!=null){
      map['backgroundGradientColors'].forEach((g){
        colorsList.add(g);
      });
    }

    return AgentModel(
      displayName: map['displayName'],
      description: map['description'],
      displayIcon: map['displayIcon'],
      fullPortrait: map['fullPortrait'],
      background: map['background'],
      backgroundGradientColors: colorsList,
      role: role,
      abilities: abilitiesList 
    );
  }
}

class Role {
  String? displayName;
  String? displayIcon;

  Role({
    this.displayName,
    this.displayIcon,
  });

  factory Role.fromMap(Map<String,dynamic> map){
    return Role(
      displayName: map['displayName'],
      displayIcon: map['displayIcon']
    );
  }
}

class Abilities {
  String? displayName;
  String? description;
  String? displayIcon;

  Abilities({
    this.displayName,
    this.description,
    this.displayIcon
  });

  factory Abilities.fromMap(Map<String, dynamic> map){
    return Abilities(
      displayName: map['displayName'],
      description: map['description'],
      displayIcon: map['displayIcon']
    );
  }
}