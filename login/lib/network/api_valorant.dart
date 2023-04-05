import 'dart:convert';

import 'package:login/models/agent_model.dart';

import 'package:http/http.dart' as http;

class ApiValorant {

  Future<List<AgentModel>?> getAgents() async{
    Uri url = Uri.parse("https://valorant-api.com/v1/agents?isPlayableCharacter=true&language=es-MX");
    var result = await http.get(url);
    var jsonDecoded = jsonDecode(result.body)['data'] as List;
    if(result.statusCode==200){
      return jsonDecoded.map((res)=>AgentModel.fromMap(res)).toList();
    }
    return null;
  }
}