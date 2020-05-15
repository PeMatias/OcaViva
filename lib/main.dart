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
     
     var usuarios = abrirCaixa() ;
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
      theme: ThemeData(
        //primarySwatch: Colors.blueGrey,
        primarySwatch: Colors.blue,
        //primarySwatch: Colors.deepPurple,
        //primarySwatch: Colors.indigo,
        canvasColor: Colors.white,
        textTheme: GoogleFonts.dosisTextTheme(),
        /*textTheme: GoogleFonts.playTextTheme(textTheme).copyWith(
          body1: GoogleFonts.play(textStyle: textTheme.body1),
          title:  GoogleFonts.play(textStyle: textTheme.title),
        ),*/
       // primarySwatch: Colors.yellow[800] ,
        /*textTheme: GoogleFonts.quanticoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.quantico(textStyle: textTheme.body1),
        ),*/
      ),
      //home: WelcomePage() ,
      
      initialRoute: (prefs.getBool('seen') != null)?((prefs.getBool('seen') && prefs.getBool('logado')!=null && prefs.getBool('logado') && prefs.getString('email')!=null)?'/home': '/login' ):'/',
      routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => WelcomePage(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/login': (context) => LoginPage(),
      '/registro': (context) => RegistroPage(),
      '/home': (context)=> HomePage(),
      '/problemas': (context)=> PageMain()   ,
      '/perfil': (context)=> Perfil(),
   
      //'/tinder': (context)=> SwipeFeedPage(),
     },
      debugShowCheckedModeBanner: false,
    );
  }
}


