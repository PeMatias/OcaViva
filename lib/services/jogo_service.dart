 
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import 'package:ocaviva/models/usuario.dart';

import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/models/users.dart';
import 'package:ocaviva/widgets/PageReveal/pages.dart';
import 'package:path_provider/path_provider.dart';



Future<String> _carregaJogoAsset() async {
  return await rootBundle.loadString('assets/jogo.json');
}


Future<Jogo> carregaJogo(int fase) async {
  String jsonString = await _carregaJogoAsset(); // carregando a String json bruta dos ativos.
  //final jsonResponse = json.decode(jsonString); //Decodificando essa String json bruta que obtivemos.
  //Jogo ocaviva = new Jogo.fromJson(jsonResponse); //E agora estamos desserializando a resposta json decodificada
  //List<Jogo> ocaviva = jsonResponse.map((x) => Jogo.fromJson(x)).toList();
  List<Jogo> ocaviva = jogoFromJson(jsonString) ;
  desafioPages = ocaviva[fase-1].desafioList;
    
  
  
  //print(ocaviva[0].desafioList[0].desafio.toString());
  return  ocaviva[fase-1];
}


Future<String> _carregaUsersAsset() async {
  return await rootBundle.loadString('assets/users.json');
}


void escreveUsers(Users usuario) async {
  String jsonString = await _carregaUsersAsset(); // carregando a String json bruta dos ativos.
  List<Users> usuarios = usersFromJson(jsonString);
  usuarios.add(usuario);
  usersToJson(usuarios);
  _carregaUsersAsset().asStream();
  
  //print(ocaviva[0].desafioList[0].desafio.toString());
}

Future<Box<Usuario>> abrirCaixa() async { 
   
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  
  return Hive.openBox<Usuario>("users");
}
/*Future caixaUsuarios() async {  
  //Hive.registerAdapter(UsuarioAdapter());
  Hive.registerAdapter(UsuarioAdapter());
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  return await Hive.openBox<Usuario>('users');
}*/

