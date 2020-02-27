class Jogo {
  int fase;
  List<DesafioList> desafioList;

  Jogo({this.fase, this.desafioList});

  Jogo.fromJson(Map<String, dynamic> json) {
    fase = json['fase'];
    if (json['desafioList'] != null) {
      desafioList = new List<DesafioList>();
      json['desafioList'].forEach((v) {
        desafioList.add(new DesafioList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fase'] = this.fase;
    if (this.desafioList != null) {
      data['desafioList'] = this.desafioList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DesafioList {
  String desafio;
  List<ProblemaList> problemaList;

  DesafioList({this.desafio, this.problemaList});

  DesafioList.fromJson(Map<String, dynamic> json) {
    desafio = json['desafio'];
    if (json['problemaList'] != null) {
      problemaList = new List<ProblemaList>();
      json['problemaList'].forEach((v) {
        problemaList.add(new ProblemaList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desafio'] = this.desafio;
    if (this.problemaList != null) {
      data['problemaList'] = this.problemaList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProblemaList {
  String problema;
  List<RespostaList> respostaList;

  ProblemaList({this.problema, this.respostaList});

  ProblemaList.fromJson(Map<String, dynamic> json) {
    problema = json['problema'];
    if (json['respostaList'] != null) {
      respostaList = new List<RespostaList>();
      json['respostaList'].forEach((v) {
        respostaList.add(new RespostaList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['problema'] = this.problema;
    if (this.respostaList != null) {
      data['respostaList'] = this.respostaList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RespostaList {
  String resposta;
  int ponto;

  RespostaList({this.resposta, this.ponto});

  RespostaList.fromJson(Map<String, dynamic> json) {
    resposta = json['resposta'];
    ponto = json['ponto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resposta'] = this.resposta;
    data['ponto'] = this.ponto;
    return data;
  }
}