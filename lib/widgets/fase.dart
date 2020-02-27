import 'package:flutter/material.dart';
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
    return  Container
    (
      width: 130.0,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(asset), fit: BoxFit.fitHeight,),
      ),
      alignment: Alignment.center ,
      child: Align(alignment: Alignment.bottomCenter,
        child: Texto(conteudo: legenda, tamFonte:15.0),
      ),
    );
  }
}