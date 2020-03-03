import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocaviva/screens/welcomePage.dart';
import 'package:ocaviva/widgets/PageReveal/page_main.dart';
import 'package:ocaviva/widgets/SwipeAnimation/index.dart';

import 'screens/home_page.dart';
import 'screens/loginPage.dart';
import 'screens/registroPage.dart';
import 'screens/welcomePage.dart';


void main() 
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new MyApp());
    });  

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'OCAVIVA',
      theme: ThemeData(
        //primarySwatch: Colors.purple,
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.quanticoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.quantico(textStyle: textTheme.body1),
        ),
      ),
      //home: WelcomePage() ,
      initialRoute: '/',
      routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => WelcomePage(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/login': (context) => LoginPage(),
      '/registro': (context) => RegistroPage(),
      '/home': (context)=> HomePage(),
      '/problemas': (context)=> CardDemo(),
     },
      debugShowCheckedModeBanner: false,
    );
  }
}
