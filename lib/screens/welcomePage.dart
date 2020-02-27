import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ocaviva/screens/loginPage.dart';
import 'package:ocaviva/screens/registroPage.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/botao.dart';

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
                Texto(conteudo: fraseInicial, tamFonte: 20),
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
                ) , 

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
        new MaterialPageRoute(builder: (context) => new LoginPage()));
      log("Tela de Login");
    }
    else
    {
        await prefs.setBool('seen', true);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new WelcomePage()));
        log("Tela de welcome");
    }
  }
}