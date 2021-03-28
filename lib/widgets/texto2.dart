import 'package:flutter/material.dart';

class Texto2 extends StatelessWidget 
{
  final String conteudo;
  final double tamFonte;
  const Texto2
  ({
    Key key,
    @required this.conteudo,
    @required this.tamFonte,
  })
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack
    ( 
      alignment: Alignment.center,
      children: <Widget> 
      [
        Text
        (
          "$conteudo", // texto com borda feito com Stroke .
          //textAlign: TextAlign.center,
          textAlign: TextAlign.left,
          softWrap: true,
          style: TextStyle
          (
            fontSize: tamFonte,
            color: Colors.white,
            height: 1.5,
             fontWeight: FontWeight.w500
            
          ),
        ),
        /*Text
        ( 
          "$conteudo", // texto com solida em branco
          //textAlign: TextAlign.center,
          textAlign: TextAlign.justify,
          style: TextStyle
          (
            fontSize: tamFonte,
            color: Colors.white,
          ),
          semanticsLabel: "",
        ),*/
      ],
    );
  }
}

class Texto3 extends StatelessWidget 
{
  final String conteudo;
  final double tamFonte;
  const Texto3
  ({
    Key key,
    @required this.conteudo,
    @required this.tamFonte,
  })
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack
    ( 
      alignment: Alignment.center,
      children: <Widget> 
      [
        Text
        (
          "$conteudo", // texto com borda feito com Stroke .
          //textAlign: TextAlign.center,
          textAlign: TextAlign.left,
          softWrap: true,
          style: TextStyle
          (
            fontSize: tamFonte,
            color: Colors.white,
            height: 1.5,
            fontWeight: FontWeight.w500
            
          ),
        ),
        /*Text
        ( 
          "$conteudo", // texto com solida em branco
          //textAlign: TextAlign.center,
          textAlign: TextAlign.left,
          style: TextStyle
          (
            fontSize: tamFonte,
            color: Colors.white,
          ),
          semanticsLabel: "",
        ),*/
      ],
    );
  }
}
 
