import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:ocaviva/main.dart';
import 'package:ocaviva/models/firestore.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/screens/home_page.dart';
import 'package:ocaviva/screens/loginPage.dart';
import 'package:ocaviva/screens/registroPage.dart';
import 'package:ocaviva/screens/tela_nova.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/botao.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/jogo_service.dart';

class WelcomePage extends StatefulWidget
{
  @override
  WelcomeState createState() {
    return new WelcomeState();
  }
}

 var tela;

class WelcomeState extends State<WelcomePage>
{
  @override
  void initState() 
  {
     userAuth = Mobxfirestore();
     //SystemChrome.setEnabledSystemUIOverlays([]);
     //SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top])
    

    
      

     // 
   
     
     
        super.initState();
  
    //checkFirstSeen();
    
    //checkFirstSeen();
 
  }

  @override
  Widget build(BuildContext context) 
  {
    Size screenSize = MediaQuery.of(context).size;
    final GlobalKey<State> _keyLoader = new GlobalKey<State>();

    //double screenWidth = screenSize.width;
    String fraseInicial = "Olá,  \nvejo que é a sua primeira\n vez aqui\n Vamos começar!\n\n Se não possui conta, então:\n";
    return Scaffold(
    body: Stack(
                children: <Widget>[
                  BodyBackground(),
                  Center(
                    child: FutureBuilder(
                      future:abrirCaixa(),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                          return FutureBuilder(
                             future:checkFirstSeen(),
                              builder: (_, snapshot1) {
                                if (snapshot1.connectionState == ConnectionState.done && snapshot1.hasData) {
                                  return Center(child: CircularProgressIndicator(),);
                                }
                                else{
                                  return SimpleDialog(
                                  key: _keyLoader,
                                  backgroundColor: Colors.white,
                                  children: <Widget>[
                                    Center(
                                      child: Column(children: [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 10,),
                                        Text("A cidade como organismo vivo....",style: TextStyle(color: Colors.blue[900] ),)
                                      ]),
                                    )
                                  ] 
                          );

                                }
                              }

                          );
                        } else {
                          return SimpleDialog(
                                  key: _keyLoader,
                                  backgroundColor: Colors.white,
                                  children: <Widget>[
                                    Center(
                                      child: Column(children: [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 10,),
                                        Text("A cidade como organismo vivo....",style: TextStyle(color: Colors.blue[900] ),)
                                      ]),
                                    )
                                  ] 
                          );
                        }
                      }
                    )
                 ),
                ]
              )
                  
      
    );
  }

  Future checkFirstSeen() async 
  {
    
   
    prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    bool _logado = (prefs.getBool('logado') ?? true);
    
    log('visto: '+prefs.getBool('seen').toString());
    log('logado: '+prefs.getBool('logado').toString());
    Box<Usuario> boxUsers = Hive.box<Usuario>('users');
    var fire =  userAuth.getFromFirestore();
    
  

    if (_seen!= null && _logado!= null && _seen == true && _logado == false)
    {
        return Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new LoginPage())); 

    }
    if( _seen!= null && _logado!= null && _seen == true && _logado == true && prefs.getString('email')!= null)
    {
        
        var key = prefs.getString('email')+prefs.getString('senha');
        userAuth.usuario = boxUsers.get(key);
        log("Tela de home");
       return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
    }

    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> NovaPage()));
    
   
  
  }
  
}