import 'package:flutter/material.dart';
import 'package:ocaviva/widgets/circular_chart.dart';
import 'package:ocaviva/widgets/texto.dart';

class Fase extends StatelessWidget 
{
  

  final String asset;
  final String legenda;
  const Fase
  ({
    Key key,
    @required this.asset,
    @required this.legenda,
  })
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[

    Container
    (
      width: 100.0,
      height: 310,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(asset), fit: BoxFit.fitHeight,),
      ),
      alignment: Alignment.center ,
      child: Align(alignment: Alignment.bottomCenter,
        child: Texto(conteudo: legenda, tamFonte:15.0),
      ),
    ),
    new AnimatedRadialChartExample(value: 50.0),
    ]);
  }
}