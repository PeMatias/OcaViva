import 'dart:ui';

import 'package:charts_flutter/flutter.dart' as charts;

class Pontuacao
{
  final String status;
  final int total;
  final charts.Color color;

  Pontuacao(this.status, this.total, Color color):
   this.color = new charts.Color(
     g: color.green
   );

}