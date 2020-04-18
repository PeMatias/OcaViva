import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/models/firestore.dart';
import 'package:ocaviva/screens/loginPage.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/campoEntrada.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/botao.dart';


final Mobxfirestore firestore = Mobxfirestore();

class RegistroPage extends StatefulWidget
{
  @override
  RegistroState createState() {
    return new RegistroState();
  }
}

class RegistroState extends State<RegistroPage>
{
  @override
  void initState() 
  {
    super.initState();
  }

  final TextEditingController _nome = TextEditingController();
  final TextEditingController _escola = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  FocusNode _nomeFocusNode = new FocusNode();
  FocusNode _escolaFocusNode = new FocusNode();
  FocusNode _emailFocusNode = new FocusNode();
  FocusNode _senhaFocusNode = new FocusNode();

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
                SizedBox(height: 8, ),
                //Image.asset('assets/images/oca_viva-logo.png',height: 92,width: 911,),
                //SizedBox(height: 10, ),
                Expanded
                (
                  child: ListView
                  (
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(25),
                    children: <Widget>
                    [ 
                      CampoEntrada(titulo: "Nome", textoDica: "o nome completo",icone: Icons.person, isPassword: false,controller: _nome, focusNode: _nomeFocusNode,),
                      CampoEntrada(titulo: "Escola", textoDica: "sua escola",icone: Icons.school, isPassword: false, controller: _escola, focusNode: _escolaFocusNode,),
                      CampoEntrada(titulo: "Email", textoDica: "seu email",icone: Icons.email, isPassword: false,controller: _email, focusNode: _emailFocusNode,),
                      CampoEntrada(titulo: "Senha", textoDica: "sua senha",icone: Icons.lock, isPassword: true,controller: _senha, focusNode: _senhaFocusNode,),
                      SizedBox(height: 30,),
                      InkWell
                      ( 
                        onTap: () { 
                          if (verificaCampos())
                          {
                            Alert(context: context, title: "Cadastro não efetuado", desc: "Por favor verifique todos os campos, apenas quando todos forem preenchidos corretamente seu cadastrado será realizado").show();
                          }
                          else
                          {
                            var usuario = Usuario(_nome.text, _escola.text,  _email.text, _senha.text);
                            firestore.pushToFirestore(usuario);
                            firestore.CadastraEmail(usuario);
                            _nome.clear();
                            _escola.clear();
                            _email.clear();
                            _senha.clear();
                            _nomeFocusNode.unfocus();
                            _escolaFocusNode.unfocus();
                            _emailFocusNode.unfocus();
                            _senhaFocusNode.unfocus();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage() ) );
                          }                          
                           },
                        child: Botao(conteudo: "Cadastrar", tamFonte: 25)
                      ) ,   
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: Text('Esqueceu sua senha?\t',
                        style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(height:10),
                      Align(alignment: Alignment.bottomCenter,child: _loginAccountLabel(), ),
                    ],
                  ),                  
                ),
                //Positioned(top: 40, left: 0, child: _backButton()),

              ]

            ),
          ),
        ],
      )
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, ),
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
            Texto(conteudo: 'Voltar', tamFonte: 14.0)
          ],
        ),
      ),
    );
  }

  bool verificaCampos()
    {
      if(_nome.text.length == 0)
      {
        Alert(context: context, title: "Erro no preenchimento", desc: "o campo NOME não pode ficar vazio").show();
        return true;
      }
      if(_escola.text.length == 0)
      {
        Alert(context: context, title: "Erro no preenchimento", desc: "o campo ESCOLA não pode ficar vazio").show();
        return true;
      }
      if(_email.text.length == 0 || !(_email.text.contains("@")) )
      {
        Alert(context: context, title: "Erro no preenchimento", desc: "o campo EMAIL não pode ficar vazio e deve ser válido").show();
        return true;
      }
      if(_senha.text.length < 6 )
      {
        Alert(context: context, title: "Erro no preenchimento", desc: "o campo SENHA deve ter no mínimo 6 caracteres").show();
        return true;
      }
      return false;
      
    }


}