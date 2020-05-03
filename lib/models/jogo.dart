// To parse this JSON data, do
//
//     final jogo = jogoFromJson(jsonString);

import 'dart:convert';

List<Jogo> jogoFromJson(String str) => List<Jogo>.from(json.decode(str).map((x) => Jogo.fromJson(x)));

String jogoToJson(List<Jogo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jogo {
    int fase;
    String habilidades;
    List<DesafioList> desafioList;
    String desc;

    Jogo({
        this.fase,
        this.habilidades,
        this.desafioList,
        this.desc,
    });

    factory Jogo.fromJson(Map<String, dynamic> json) => Jogo(
        fase: json["fase"],
        habilidades: json["habilidades"],
        desafioList: List<DesafioList>.from(json["desafioList"].map((x) => DesafioList.fromJson(x))),
        desc: json["desc"],
    );

    Map<String, dynamic> toJson() => {
        "fase": fase,
        "habilidades": habilidades,
        "desafioList": List<dynamic>.from(desafioList.map((x) => x.toJson())),
        "desc": desc,
    };
}

class DesafioList {
    String desafio;
    String imagem;
    String imagemfeedback;
    String desc;
    String ods;
    List<FeedbackList> feedbackList;
    List<ProblemaList> problemaList;

    DesafioList({
        this.desafio,
        this.imagem,
        this.imagemfeedback,
        this.desc,
        this.ods,
        this.feedbackList,
        this.problemaList,
    });

    factory DesafioList.fromJson(Map<String, dynamic> json) => DesafioList(
        desafio: json["desafio"],
        imagem: json["imagem"],
        imagemfeedback: json["imagemfeedback"],
        desc: json["desc"],
        ods: json["ods"],
        feedbackList: List<FeedbackList>.from(json["feedbackList"].map((x) => FeedbackList.fromJson(x))),
        problemaList: List<ProblemaList>.from(json["problemaList"].map((x) => ProblemaList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "desafio": desafio,
        "imagem": imagem,
        "imagemfeedback": imagemfeedback,
        "desc": desc,
        "ods": ods,
        "feedbackList": List<dynamic>.from(feedbackList.map((x) => x.toJson())),
        "problemaList": List<dynamic>.from(problemaList.map((x) => x.toJson())),
    };
}

class FeedbackList {
    String resposta;

    FeedbackList({
        this.resposta,
    });

    factory FeedbackList.fromJson(Map<String, dynamic> json) => FeedbackList(
        resposta: json["resposta"],
    );

    Map<String, dynamic> toJson() => {
        "resposta": resposta,
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
