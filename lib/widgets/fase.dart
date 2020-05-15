import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ocaviva/main.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/widgets/circular_chart.dart';
import 'package:ocaviva/widgets/texto.dart';

Box<Usuario> boxUsers = Hive.box<Usuario>('users');
class Fase extends StatelessWidget 
{
  

  final String asset;
  final int fase;
  final String legenda;
  const Fase
  ({
    Key key,
    @required this.asset,
     @required this.fase,
    @required this.legenda,
  })
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    var aux = userAuth.usuario.score[fase];
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
      (fase<1) ? new Icon(Icons.lock_open, color: Colors.lightGreen,) : new Icon(Icons.lock,color: Colors.red),
    
     Container
    (
      width: 85.0,
      height: MediaQuery.of(context).size.height*0.35,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(asset), fit: BoxFit.fitHeight,),
      ),
      alignment: Alignment.center ,
      child: Align(alignment: Alignment.bottomCenter,
        child: Texto(conteudo: legenda, tamFonte:14.0),
      ),
    ),
    new AnimatedRadialChartExample(value: aux),
    ]);
  }
}