// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    String email;
    String senha;
    String nome;
    String escola;
    String ocaviva;
    int pontos;
    List<List<int>> fase;

    Users({
        this.email,
        this.senha,
        this.nome,
        this.escola,
        this.ocaviva,
        this.pontos,
        this.fase,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        email: json["email"],
        senha: json["senha"],
        nome: json["nome"],
        escola: json["escola"],
        ocaviva: json["ocaviva"],
        pontos: json["pontos"],
        fase: List<List<int>>.from(json["fase"].map((x) => List<int>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "senha": senha,
        "nome": nome,
        "escola": escola,
        "ocaviva": ocaviva,
        "pontos": pontos,
        //"fase": List<dynamic>.from(fase.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}
