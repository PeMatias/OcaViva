import 'package:flutter/material.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/services/jogo_service.dart';
import 'package:ocaviva/widgets/PageReveal/page_main.dart';
import 'package:ocaviva/widgets/SwipeAnimation/index.dart';
import 'package:ocaviva/widgets/texto.dart';

import 'texto2.dart';

class DesafioRow extends StatelessWidget {

  final DesafioList desafio;

  DesafioRow(this.desafio);

  @override
  Widget build(BuildContext context) {
    final desafioThumbnail = new Container(
      alignment: new FractionalOffset(0, 0.5),
      margin: const EdgeInsets.only(left: 0.0),
      child: new Hero(
        tag: 'desafio-icon-${desafio.desafio}',
        child: CircleAvatar(
          child: Texto2(conteudo: "0"+"/"+desafio.problemaList.length.toString(), tamFonte:30.0),
          backgroundColor: Colors.orange,
          radius: 40,
          )
        /*child: new Image(
          image: new AssetImage('assets/images/oca_viva-logo.png'),
          height: 110,
          width: 105,
        ),*/
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
        margin: const EdgeInsets.only(left: 68.0, right: 10.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Texto2(conteudo: desafio.desafio, tamFonte: 15.0),
            Align(alignment: Alignment.bottomRight,child: Texto2(conteudo: "\nProblemas: "+desafio.problemaList.length.toString(), tamFonte:10.0)),
            
          ],
        ),
      ),
    );

    return new Container(
      height: 150.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new FlatButton(
        onPressed: () => Navigator.of(context).pushNamed("/problemas"),//_navigateTo(context, desafio.id),

        child: new Stack(
          children: <Widget>[
            desafioCard,
            desafioThumbnail,
          ],
        ),// onPressed: () {},
      ),
    );
  }

  
}