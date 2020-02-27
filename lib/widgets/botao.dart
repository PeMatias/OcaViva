import 'package:flutter/material.dart';
import 'package:ocaviva/widgets/texto.dart';

class Botao extends StatelessWidget 
{
  final String conteudo;
  final double tamFonte;
  const Botao
  ({
    Key key,
    @required this.conteudo,
    @required this.tamFonte,
  })
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container
    (
      width: MediaQuery.of(context).size.width /1.2,
      padding: EdgeInsets.symmetric(vertical: 13),
      //padding: EdgeInsets.all(18.0),
      alignment: Alignment.center,
      decoration: BoxDecoration
      (
        borderRadius: BorderRadius.all( Radius.circular(28.0) ),
        border: Border.all(color: Colors.yellow[700], width: 2),
        color: Colors.yellow[700],
        boxShadow: <BoxShadow>
        [
          BoxShadow
          (
            color: Colors.yellow[700],
            blurRadius: 3,
            spreadRadius: 2,
          )
        ],
      ), 
      child: Texto(conteudo: conteudo,tamFonte: tamFonte),
    );
  }
}