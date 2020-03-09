import 'package:flutter/material.dart';
import 'package:ocaviva/models/desafio.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/services/jogo_service.dart';

import 'desafioRow.dart';





class DesafioList extends StatelessWidget {
  final int fase;
  DesafioList({this.fase});

  @override
  Widget build(BuildContext context) {
        return new Flexible(
          fit: FlexFit.tight,
          child: new Container(
            child: FutureBuilder(
              future: carregaJogo(fase),
              builder: (BuildContext context,ocaviva) {
                print(ocaviva.data.desafioList[0].desafio);

               // builder: (BuildContext context, AsyncSnapshot<Jogo> ocaviva) {
                if (ocaviva.connectionState==null || !ocaviva.hasData)
                  return  CircularProgressIndicator();
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: ocaviva.data.desafioList.length,
                  itemExtent: 160.0,                    
                  itemBuilder: (_, index) => new DesafioRow( ocaviva.data.desafioList[index])
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