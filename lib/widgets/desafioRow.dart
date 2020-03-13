import 'package:flutter/material.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/widgets/SwipeAnimation/index.dart';
import 'package:pie_chart/pie_chart.dart';
import 'circular_chart.dart';
import 'texto2.dart';

class DesafioRow extends StatelessWidget {

  AnimatedRadialChartExample score;


  final DesafioList desafios;

  DesafioRow(this.desafios, this.score);

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = new Map();
    //dataMap.putIfAbsent("F", ()=> desafios.problemaList.length.toDouble() );
    dataMap.putIfAbsent("F", ()=> 1 );
    dataMap.putIfAbsent("T", ()=> 4 );
    final desafioThumbnail = new Container(
     // alignment: Alignment.centerRight,
      alignment: new FractionalOffset(0, 0.5),
      margin: const EdgeInsets.only(left: 0.0),
      child: new Hero(
        tag: 'desafio-icon-${desafios.desafio}',
        child: Container(
        child: PieChart(dataMap: dataMap,
           animationDuration: Duration(milliseconds: 1000),
           showLegends: false,
           chartValueFontSize: 12,
           chartRadius: 78,
           showChartValueLabel: false,
           showChartValuesInPercentage: true,
           showChartValues: false,
           showChartValuesOutside: false,
           decimalPlaces: 0,
            ),
        )

      ),
    );
  

    final desafioCard = new Container(
      margin: const EdgeInsets.only(left: 36.0, right: 20.0),
      decoration: new BoxDecoration(
        color: Colors.blue[800],
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(color: Colors.black,
            blurRadius: 5.0,
            offset: new Offset(0.0, 10.0))
        ],
      ),
      child: new Container(
        margin: const EdgeInsets.only(left: 50.0, right: 10.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Texto2(conteudo: desafios.desafio, tamFonte: 13),
            
            
          ],
        ),
      ),
    );

    return new Container(
      height: 150.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new FlatButton(
       // onPressed: () => Navigator.of(context).pushNamed("/problemas"),//_navigateTo(context, desafio.id),
       onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => 
        CardDemo(problemas: desafios.problemaList, desafios: desafios,) ) ),

        child: new Stack(
          children: <Widget>[
            desafioCard,
            Positioned(top:20,left: -20,child: Align(alignment: Alignment.center,child: desafioThumbnail,)),
          ],
        ),// onPressed: () {},
      ),
    );
  }

  
}