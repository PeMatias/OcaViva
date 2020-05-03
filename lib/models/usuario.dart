import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'usuario.g.dart';


@HiveType(typeId: 1)
class Usuario 
{
  @HiveField(0)
  String nome;
  @HiveField(1)
  String escola;
  @HiveField(2)
  String email;
  @HiveField(5)
  String senha;
  @HiveField(6)
  bool aluno = true;
  @HiveField(7)
  String documentID;
  @HiveField(8)
  List score = [35,35,35,35,35] ;
  @HiveField(9)
  List desempenho = [0,0,0,0,0];


  Usuario(this.nome, this.escola, this.email, this.senha, this.aluno);



  Usuario.fromfirestoresnapshot(DocumentSnapshot snap):
    documentID = snap.documentID,
    nome = snap.data['nome'] ,
    escola = snap.data['escola'],
    email = snap.data['email'],
    senha = snap.data['senha'],
    aluno = snap.data['aluno'],
    score = snap.data['score']   ,
    desempenho = snap.data['desempenho'];

  toJson()
  {
    return 
    {
      'nome' : nome,
      'escola': escola,
      'email': email,
      'senha': senha,
      'aluno': aluno,
      'score': score,
      'desempenho':desempenho,
    };
  }



}