import 'package:flutter/material.dart';

class BodyBackground extends StatelessWidget
{
  BodyBackground({Key key }) : super(key: key);

  final Color gradientStart = Colors.indigo[900]; //Change start gradient color here
  final Color gradientEnd = Colors.lightBlue[900]; //Change end gradient color here

  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration
      (
        //color: Colors.blue[900],
      
        gradient: LinearGradient
        (
          
          colors: [gradientStart, gradientEnd],
          begin: const FractionalOffset(0.5, 0.0),
          end: const FractionalOffset(0.0, 0.5),
          stops: [0.0,1.0],
          tileMode: TileMode.clamp
          
        ),
      ),
    );
  }
}
