import 'package:flutter/material.dart';
import 'package:ocaviva/models/desafio.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/services/jogo_service.dart';

import 'dasafioRow.dart';

Desafio d1 = new Desafio(id:'1',name: "D1:",image: 'assets/images/oca_viva-logo.png',desc: "A população de um bairrro da sua cidade está reivindicando o acesso  a um direito fundamental que é o sanemanto básico.");
Desafio d2 = new Desafio(id:'2',name: 'D2',image: 'assets/images/oca_viva-logo.png',desc: '');
Desafio d3 = new Desafio(id:'3',name: 'D3',image: 'assets/images/oca_viva-logo.png',desc: '');
Desafio d4 = new Desafio(id:'4',name: 'D4',image: 'assets/images/oca_viva-logo.png',desc: '');
Desafio d5 = new Desafio(id:'5',name: 'D5',image: 'assets/images/oca_viva-logo.png',desc: '');
Desafio d6 = new Desafio(id:'6',name: 'D6',image: 'assets/images/oca_viva-logo.png',desc: '');
Desafio d7 = new Desafio(id:'7',name: 'D7',image: 'assets/images/oca_viva-logo.png',desc: '');
Desafio d8 = new Desafio(id:'8',name: 'D8',image: 'assets/images/oca_viva-logo.png',desc: '');



class DesafioList extends StatelessWidget {
  final int fase;
  DesafioList({this.fase});

  @override
  Widget build(BuildContext context) {
        return new Flexible(
          fit: FlexFit.tight,
          child: new Container(
            child: FutureBuilder(
              future: carregaJogo(),
              builder: (BuildContext context, AsyncSnapshot<List<Jogo>> ocaviva) {
                if (!ocaviva.hasData)
                  return new Container();
                 List desafios = ocaviva.data[fase-1].desafioList;
                 return new ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemExtent: 160.0,
                    itemCount: desafios.length,
                    itemBuilder: (_, index) => new DesafioRow(desafios[index])
                 );
              }
            ),
            /*
            child: new ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemExtent: 10.0,
              itemCount: carregaDesafio(fase).length,
              itemBuilder: (_, index) => new DesafioRow(carregaDesafio(fase)[index]),
        ),*/

        /*child: new ListView(
          children: <Widget>
          [
            /*
            DesafioRow(d1),
            DesafioRow(d2),
            DesafioRow(d3),
            DesafioRow(d4),
            DesafioRow(d5),
            DesafioRow(d6),
            DesafioRow(d7),*/
        
          ],
          
        ),*/
      ),
    );
  }
}