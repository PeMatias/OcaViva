import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/welcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'OcaViva',
      theme: ThemeData(
        // Definindo o padrão de brilho e das cores
        brightness: Brightness.light,
        /*primaryColor: Colors.yellow[700],
        accentColor: Colors.white,*/
         ///primarySwatch: Colors.blue,
         textTheme:GoogleFonts.quanticoTextTheme().copyWith(         
           body1: GoogleFonts.quantico(textStyle: textTheme.body1),
           body2: GoogleFonts.quantico(textStyle: textTheme.body2)
         ),
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
