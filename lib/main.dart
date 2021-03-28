import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/screens/perfil.dart';
import 'package:ocaviva/screens/welcomePage.dart';

import 'package:hive/hive.dart';
import 'package:ocaviva/services/jogo_service.dart';
import 'package:ocaviva/widgets/PageReveal/page_main.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'models/firestore.dart';
import 'screens/home_page.dart';
import 'screens/loginPage.dart';
import 'screens/registroPage.dart';
import 'screens/welcomePage.dart';



Mobxfirestore userAuth = Mobxfirestore();
SharedPreferences prefs;

void main() async 
{
  
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  log('visto: '+prefs.getBool('seen').toString());
  log('logado: '+prefs.getBool('logado').toString());
  //Hive.registerAdapter(UsuarioAdapter());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) async {
       Hive.registerAdapter(UsuarioAdapter());
     
     //var usuarios = abrirCaixa() ;
      runApp(new MyApp());
     
     
    });  
   //abrirCaixa();
    
    
        


}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // showDialog(context: context, child: Center(child: CircularProgressIndicator()));
    /*if( prefs.getBool('seen')!= null && prefs.getBool('seen') && prefs.getBool('logado')
      && prefs.getBool('email')!= null && userAuth.usuario == null)
      {
        Box<Usuario> boxUsers = Hive.box<Usuario>('users');
        var key = prefs.getString('email')+prefs.getString('senha');

        userAuth.usuario = boxUsers.get(key);

      }*/
    
 

    return MaterialApp(
      title: 'OCAVIVA',
      theme: (isDark== false)? ThemeData(
        //primarySwatch: Colors.blueGrey,
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        //primarySwatch: Colors.deepPurple,
        //primarySwatch: Colors.indigo,
        canvasColor: Colors.white,
            iconTheme: IconThemeData(color:Colors.yellow[800]),
        appBarTheme: AppBarTheme(
          textTheme: GoogleFonts.abelTextTheme(),
          iconTheme: IconThemeData(color:Colors.yellow[800],size: 35)
        ),
       // scaffoldBackgroundColor: Colors.blue,
        ///textTheme: GoogleFonts.heeboTextTheme(),
        textTheme: GoogleFonts.abelTextTheme(textTheme).copyWith(
          body1: GoogleFonts.abel(textStyle: textTheme.body1),
          title:  GoogleFonts.abel(textStyle: textTheme.title),
          headline:   GoogleFonts.abel(textStyle: textTheme.title),
        ),
       
       // primarySwatch: Colors.yellow[800] ,
        /*textTheme: GoogleFonts.quanticoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.quantico(textStyle: textTheme.body1),
        ),*/
      ):ThemeData(
         primaryColorDark: Colors.white,
         iconTheme: IconThemeData(color:Colors.white),
         //disabledColor: Colors.black,
          primarySwatch: Colors.blue,
           brightness: Brightness.dark,
           textTheme: GoogleFonts.abelTextTheme(textTheme).copyWith(
          body1: GoogleFonts.abel(textStyle: textTheme.body1),
          title:  GoogleFonts.abel(textStyle: textTheme.title),
          headline:   GoogleFonts.abel(textStyle: textTheme.title),
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
      '/perfil': (context)=> Perfil(),
   
      //'/tinder': (context)=> SwipeFeedPage(),
     },
      debugShowCheckedModeBanner: false,
    );
  }
}


