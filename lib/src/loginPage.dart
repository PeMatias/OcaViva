import 'package:flutter/material.dart';
import 'package:ocaviva/src/HomePage.dart';
import 'package:ocaviva/src/signup.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widget/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.arrow_back, size: 20.0 , color: Colors.white),
              //child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            _padraoTexto('Voltar', 14.0)
          ],
        ),
      ),
    );
  }

Widget _padraoTexto(var texto, var tamFonte){
  return Stack( 
    children: <Widget> [
      Text(
        texto, // texto com borda feito com Stroke .
        style: TextStyle(
          fontSize: tamFonte,
          foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = Colors.black,
        ),
      ),
      Text( 
        texto, // texto com solida em branco
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: tamFonte,
          color: Colors.white,
        ),
      ),
    ],
  );
  }


  Widget _entryField(String title,String textoDica, IconData icone, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _padraoTexto(title, 15.0),
          SizedBox(
            height: 8,
          ),
          TextField(
            style: TextStyle(color: Colors.white,fontSize: 18.0, fontFamily: "GoogleFonts.quantico"),
            obscureText: isPassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide( style: BorderStyle.none, )
              ),
            fillColor: Colors.yellow[700],
            filled: true,
            hintText: "Digite aqui "+ textoDica,
            prefixIcon: Icon(icone),
            hintStyle: TextStyle(color: Colors.white),
            )
                )
        ],
      ),
    );
  }

  Widget _padraoBotao(var texto){
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          border: Border.all(color: Colors.yellow[700], width: 2),
          color: Colors.yellow[700],
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.yellow[700],
              blurRadius: 5,
              spreadRadius: 3)
            ],
        ),
        
        child: _padraoTexto(texto,20.0)
      );
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },     
      child: _padraoBotao('Login')
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Não possui conta ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text(
              'Registre-se',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email","seu email",Icons.email),
        _entryField("Senha", "sua senha", Icons.lock, isPassword: true),
      ],
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
             decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.4, 0.6, 0.9],
                    colors: [ Colors.deepPurple,Colors.indigo, Colors.blue, Colors.cyan ])),   
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
                Image.asset(
                'assets/images/oca_viva-logo.png',
                height: 187,
                width: 174,
                ),
                SizedBox(height: 10, ),
                _emailPasswordWidget(),
                SizedBox(height: 30, ),
                _loginButton(),
                SizedBox(height: 10, ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerRight,
                  child: Text('Esqueceu sua senha?',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _createAccountLabel(),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
          
        ],
      ),
    );
  }
}