import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/screens/home_page.dart';
import 'package:ocaviva/screens/loginPage.dart';
import 'package:ocaviva/screens/registroPage.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/botao.dart';
import '../services/jogo_service.dart';
import 'package:path_provider/path_provider.dart';


class WelcomePage extends StatefulWidget
{
  @override
  WelcomeState createState() {
    return new WelcomeState();
  }
}

class WelcomeState extends State<WelcomePage>
{
  @override
  void initState() 
  {
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) 
  {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    String fraseInicial = "Olá,  \nvejo que é a sua primeira\n vez aqui\n Vamos começar!\n\n Se não possui conta, então:\n";
    return Scaffold(
      body: Stack
      (
        children: <Widget>
        [
          BodyBackground(),
          Center(
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>
              [
                Image.asset('assets/images/oca_viva-logo.png',height: 187,width: 174,),
                FutureBuilder(
                  future: abrirCaixa(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.error != null) {
                        return Scaffold(
                          body: Center(
                            child: Text('Algo deu errado :('),
                          ),
                        );
                      } else {
                        print("abri a caixa Hive");
                        /*FutureBuilder(
                        future: caixaUsuarios(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.error != null) {
                              //var boxUsers = Hive.box<Usuario>('users'); 
                              Hive.registerAdapter(UsuarioAdapter());
                              var box = await Hive.openBox<Usuario>('users');
                              */
                              Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new LoginPage()));
                              return LoginPage();
                            /*}
                          }
                        });
                        */
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                /*Texto(conteudo: fraseInicial, tamFonte: 20),
                InkWell
                (
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => RegistroPage() )
                    );
                  },
                  child: Botao(conteudo: "Registre-se", tamFonte: 25)
                ) ,   
                Texto(conteudo: "\nSe já possui conta:\n", tamFonte: 20),
                InkWell
                (
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => LoginPage() )
                    );
                  },
                  child: Botao(conteudo: "Login", tamFonte: 25)
                ) , */

              ]

            ),
          ),
        ],
      )
    );
  }

  Future checkFirstSeen() async 
  {
 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen)
    {
      Navigator.of(context).pushReplacement(
        (userAuth.usuario != null) ? new MaterialPageRoute(builder: (context) => new HomePage())
        : new MaterialPageRoute(builder: (context) => new LoginPage()));
        //abrirCaixa();    
        //userAuth.getFromFirestore();    
        log("Tela de Login");
        
    }
    else
    {
        await prefs.setBool('seen', true);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new LoginPage()));
        log("Tela de welcome");
    }
  }
}