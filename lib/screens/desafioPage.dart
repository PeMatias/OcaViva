import 'package:flutter/material.dart';
import 'package:ocaviva/widgets/desafioList.dart';

import '../widgets/bodyBackground.dart';

class DesafioPage extends StatefulWidget
{
  DesafioPage({this.fase});
  final int fase;

  @override
  DesafioState createState() {
    return new DesafioState();
  }
}

class DesafioState extends State<DesafioPage>
{


  @override
  void initState() 
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Stack
    (
      children: <Widget>[
        BodyBackground(),
        Column(
        children: <Widget>[
          new DesafioList(fase:widget.fase),
      ]
    ),
    ]

    );
  }
}