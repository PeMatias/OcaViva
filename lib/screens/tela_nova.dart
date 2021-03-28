
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:ocaviva/main.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/screens/home_page.dart';

import 'package:ocaviva/screens/loginPage.dart';
import 'package:ocaviva/screens/registroPage.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/botao.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NovaPage extends StatefulWidget
{
  @override
  NovaState createState() {
    return new NovaState();
  }
}

class NovaState extends State<NovaPage>
{
  @override
  void initState() 
  {
    //SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);

     //SystemChrome.setEnabledSystemUIOverlays([]);
    //checkFirstSeen();
    super.initState();
   
    //checkFirstSeen();
    
    //checkFirstSeen();
 
  }

  @override
  Widget build(BuildContext context) 
  {
    Size screenSize = MediaQuery.of(context).size;
        String fraseInicial = "Olá,  \nvejo que é a sua primeira\n vez aqui\n Vamos começar!\n\n Se não possui conta, então:\n";


   
      
      return Scaffold(
        extendBody: true,
        body: Stack(

          children: <Widget>[
            BodyBackground(),
    Center(
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>
        [

            SizedBox(height: 40, ),
            Image.asset('assets/images/oca_viva-logo.png',height: 167,width: 154 ,),
            SizedBox(height: 8, ),
            Texto(conteudo: fraseInicial, tamFonte: 20),
            InkWell
            (
              onTap: () async {
                await prefs.setBool('seen', true);
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => RegistroPage() )
                );
              },
              child: Botao(conteudo: "Registre-se", tamFonte: 25)
            ) ,   
            Texto(conteudo: "\nSe já possui conta:\n", tamFonte: 20),
            InkWell
            (
              onTap: () async {
                await prefs.setBool('seen', true);
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginPage() )
                );
              },
              child: Botao(conteudo: "Login", tamFonte: 25)
            ) ,
            
          ],
        ),
      ),
          ],
        ),

      );                       
 
  }
   
  
}

 