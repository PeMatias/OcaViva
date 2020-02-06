import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:ocaviva/src/loginPage.dart';
import 'package:ocaviva/src/signup.dart';
import 'package:google_fonts/google_fonts.dart';


final String fraseInicial = 
"Olá  \n\n"
"Vejo que é a sua primeira vez aqui!\n"
"Vamos começar!\n";

final double tamFonteBotao = 20;
final double tamFonteTexto = 18;


class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  // Padrão de texto do App ocaviva com stroke+fill
  Widget _padraoTextoBotao(var texto, var tamFonte){
    return Stack( 
      children: <Widget> [
        Text(
          texto, // texto com borda feito com Stroke .
          style: TextStyle(
            fontSize: tamFonteBotao,
            foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3
            ..color = Colors.black,
          ),
        ),
        Text( 
          texto, // texto com solida em branco
          style: TextStyle(
            fontSize: tamFonte,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

    // Padrão de botões do App ocaviva
  Widget _padraoBotao(var texto, var tamFonte){
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.yellow[900], width: 2),
          color: Colors.yellow[900],
        ),
        child: _padraoTextoBotao(texto,tamFonte)
      );
  }


  //Botão de Registro -> leva para SigUpPage()
  Widget _signUpButton() { 
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },     
      child: _padraoBotao('Registre-se', tamFonteBotao)
    );
  }

//Botão de login -> leva para LoginPage()
  Widget _loginButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: _padraoBotao('Login', tamFonteBotao)
    );
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Quick login with Touch ID',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.fingerprint, size: 90, color: Colors.white),
            SizedBox(
              height: 20,
            ),
            Text(
              'Touch ID',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: fraseInicial,
          style: GoogleFonts.quantico(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
      )
    );
  }
  Widget _padraoTextoExterno(var texto, var tamFonte)
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: texto,
          style: GoogleFonts.quantico(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: tamFonte,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        )
      )
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0.1,
                      0.4,
                      0.6,
                      0.9
                    ],
                    colors: [
                      Colors.deepPurple,
                      Colors.indigo,
                      Colors.blue,
                      Colors.cyan
                    ])),
                    
                    //colors: [Color(0xfffbb448), Color(0xffe46b10)])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                'assets/images/oca_viva-logo.png',
                height: 187,
                width: 174,
                ),
                _padraoTextoExterno(fraseInicial, tamFonteTexto),
                _signUpButton(),
                SizedBox(
                  height: 20,
                ),
                _padraoTextoExterno("Se já possui conta:\n", tamFonteTexto),
                _loginButton(),
                SizedBox(
                  height: 20,
                ),
                //_label()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
