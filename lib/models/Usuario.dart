import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario
{
  String nome;
  String escola;
  String email;
  String senha;
  bool aluno = true;
  String documentID;

  Usuario(this.nome, this.escola, this.email, this.senha);



  Usuario.fromfirestoresnapshot(DocumentSnapshot snap):
    documentID = snap.documentID,
    nome = snap.data['nome'] ,
    escola = snap.data['escola'],
    email = snap.data['email'],
    senha = snap.data['senha'],
    aluno = snap.data['aluno'];

  toJson()
  {
    return 
    {
      'nome' : nome,
      'escola': escola,
      'email': email,
      'senha': senha,
      'aluno': aluno,
    };
  }



}