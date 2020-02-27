 
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:ocaviva/models/jogo.dart';

Future<String> _carregaJogoAsset() async {
  return await rootBundle.loadString('assets/jogo.json');
}


Future<List<Jogo>> carregaJogo() async {
  String jsonString = await _carregaJogoAsset(); // carregando a String json bruta dos ativos.
  //final jsonResponse = json.decode(jsonString); //Decodificando essa String json bruta que obtivemos.
  //Jogo ocaviva = new Jogo.fromJson(jsonResponse); //E agora estamos desserializando a resposta json decodificada
  //List<Jogo> ocaviva = jsonResponse.map((x) => Jogo.fromJson(x)).toList();
  List<Jogo> ocaviva = jogoFromJson(jsonString);
  print(ocaviva[0].desafioList[0].desafio.toString());
  return ocaviva;
}


