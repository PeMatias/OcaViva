// To parse this JSON data, do
//
//     final jogo = jogoFromJson(jsonString);

import 'dart:convert';

List<Jogo> jogoFromJson(String str) => List<Jogo>.from(json.decode(str).map((x) => Jogo.fromJson(x)));

String jogoToJson(List<Jogo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jogo {
    int fase;
    String desc;
    List<DesafioList> desafioList;

    Jogo({
        this.fase,
        this.desc,
        this.desafioList,
    });

    factory Jogo.fromJson(Map<String, dynamic> json) => Jogo(
        fase: json["fase"],
        desc: json["desc"] == null ? null : json["desc"],
        desafioList: List<DesafioList>.from(json["desafioList"].map((x) => DesafioList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "fase": fase,
        "desc": desc == null ? null : desc,
        "desafioList": List<dynamic>.from(desafioList.map((x) => x.toJson())),
    };
}

class DesafioList {
    String desafio;
    List<ProblemaList> problemaList;

    DesafioList({
        this.desafio,
        this.problemaList,
    });

    factory DesafioList.fromJson(Map<String, dynamic> json) => DesafioList(
        desafio: json["desafio"],
        problemaList: List<ProblemaList>.from(json["problemaList"].map((x) => ProblemaList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "desafio": desafio,
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
