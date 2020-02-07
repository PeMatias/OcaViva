import 'package:flutter/material.dart';
import 'package:ocaviva/src/Widget/bezierContainer.dart';
import 'package:ocaviva/src/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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

    // Padrão de botões do App ocaviva
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
  

  //Campos
  Widget _entryField(String title, {bool isPassword = false}) {
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
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(
                      style: BorderStyle.none,
                    )
                  ),
                  fillColor: Colors.yellow[700],
                  filled: true))
        ],
      ),
    );
  }

// Botao de registro
  Widget _registerButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },     
      child: _padraoBotao('Cadastrar')
    );
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Já possui conta ?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              'Login',
              style: TextStyle(
                  //color: Color(0xfff79c4f),
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
    return Center(
      child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: <Widget>[

        _entryField("Nome"),
        _entryField("Escola"),
        //_entryField("Username"),// n e mais necessario
        _entryField("Email"),
        _entryField("Senha", isPassword: true),
        SizedBox(height: 50,),
         _registerButton(),   
         Align(
            alignment: Alignment.bottomCenter,
            child: _loginAccountLabel(),      
          ),    
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      //resizeToAvoidBottomPadding: false,
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
                    SizedBox(height: 100,),
                    Expanded(child: _emailPasswordWidget(), ),
                    //Image.asset('assets/images/oca_viva-logo.png',height: 82, width: 81,),            
                  ],
                ),
          ),
          
          Positioned(top: 40, left: 0, child: _backButton()),
          /*Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              //child: BezierContainer())*/
        ],
      ),
    );
  }
}
