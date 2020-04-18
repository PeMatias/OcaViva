// To parse this JSON data, do
//
//     final jogo = jogoFromJson(jsonString);

import 'dart:convert';

List<Jogo> jogoFromJson(String str) => List<Jogo>.from(json.decode(str).map((x) => Jogo.fromJson(x)));

String jogoToJson(List<Jogo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jogo {
    int fase;
    List<DesafioList> desafioList;
    String desc;
    String imagem;

    Jogo({
        this.fase,
        this.desafioList,
        this.desc,
        this.imagem,
    });

    factory Jogo.fromJson(Map<String, dynamic> json) => Jogo(
        fase: json["fase"],
        desafioList: List<DesafioList>.from(json["desafioList"].map((x) => DesafioList.fromJson(x))),
        desc: json["desc"] == null ? null : json["desc"],
        imagem: json["imagem"] == null ? null : json["imagem"],
    );

    Map<String, dynamic> toJson() => {
        "fase": fase,
        "desafioList": List<dynamic>.from(desafioList.map((x) => x.toJson())),
        "desc": desc == null ? null : desc,
        "imagem": imagem == null ? null : imagem,
    };
}

class DesafioList {
    String desafio;
    String imagem;
    List<ProblemaList> problemaList;

    DesafioList({
        this.desafio,
        this.imagem,
        this.problemaList,
    });

    factory DesafioList.fromJson(Map<String, dynamic> json) => DesafioList(
        desafio: json["desafio"],
        imagem: json["imagem"] == null ? null : json["imagem"],
        problemaList: List<ProblemaList>.from(json["problemaList"].map((x) => ProblemaList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "desafio": desafio,
        "imagem": imagem == null ? null : imagem,
        "problemaList": List<dynamic>.from(problemaList.map((x) => x.toJson())),
    };
}

class ProblemaList {
    String problema;
    List<RespostaList> respostaList;

    ProblemaList({
        this.problema,
        this.respostaList,
    });

    factory ProblemaList.fromJson(Map<String, dynamic> json) => ProblemaList(
        problema: json["problema"],
        respostaList: List<RespostaList>.from(json["respostaList"].map((x) => RespostaList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "problema": problema,
        "respostaList": List<dynamic>.from(respostaList.map((x) => x.toJson())),
    };
}

class RespostaList {
    String resposta;
    int ponto;

    RespostaList({
        this.resposta,
        this.ponto,
    });

    factory RespostaList.fromJson(Map<String, dynamic> json) => RespostaList(
        resposta: json["resposta"],
        ponto: json["ponto"],
    );

    Map<String, dynamic> toJson() => {
        "resposta": resposta,
        "ponto": ponto,
    };
}
