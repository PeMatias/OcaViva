import 'package:firebase_database/firebase_database.dart';


class Usuario {
  String key;
  String nome;
  String escola;
  String email;
  String senha;

  Usuario(this.nome, this.escola, this.email, this.senha);

  Usuario.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    nome = snapshot.value["nome"],
    escola = snapshot.value["escola"],
    email = snapshot.value["email"],
    senha = snapshot.value["senha"];

  toJson() {
    return {
      "nome": nome,
      "escola": escola,
      "email": email,
      "senha": senha,
    };
  }
}
