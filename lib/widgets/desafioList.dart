import 'package:flutter/material.dart';
import 'package:ocaviva/services/jogo_service.dart';
import 'package:ocaviva/widgets/circular_chart.dart';

import 'desafioRow.dart';





class DesafioList extends StatelessWidget {
  AnimatedRadialChartExample score;

  final int fase;
  DesafioList({this.fase, this.score});

  @override
  Widget build(BuildContext context) {
        return new Flexible(
          fit: FlexFit.tight,
          child: new Container(
            child: FutureBuilder(
              future: carregaJogo(fase),
              builder: (BuildContext context,ocaviva) {
                if (ocaviva.connectionState==null || !ocaviva.hasData)
                  return  const Center(child: CircularProgressIndicator(),);
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: ocaviva.data.desafioList.length,
                  itemExtent: 180.0,                    
                  itemBuilder: (_, index) => new DesafioRow( ocaviva.data.desafioList[index],score)
                );
              }
            ),

      ),
    );
  }
}