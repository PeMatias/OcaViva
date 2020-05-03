import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/models/users.dart';
import 'package:ocaviva/screens/home_page.dart';
import 'package:ocaviva/screens/registroPage.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/campoEntrada.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/firestore.dart';
import '../widgets/botao.dart';
import '../services/jogo_service.dart';


final Mobxfirestore userAuth = Mobxfirestore();
List<Usuario> listUsers ;
Box<Usuario> boxUsers = Hive.box<Usuario>('users');




class LoginPage extends StatefulWidget
{
  @override
  LoginState createState() {
    return new LoginState();
  }
}

class LoginState extends State<LoginPage>
{
  

  @override
  void initState() 
  {
    //boxUsers.deleteFromDisk();
    //boxUsers.clear();
    //boxUsers.close();
    userAuth.getFromFirestore();
    super.initState();  
    
    
    
  }

  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();


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
                  
                    SizedBox(height: 40, ),
                    Image.asset('assets/images/oca_viva-logo.png',height: 167,width: 154 ,),
                    SizedBox(height: 8, ),
                    Expanded
                    (
                      
                      child: ListView
                      (
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(18),
                        children: <Widget>
                        [ 
                         
                          CampoEntrada(titulo: "Email", textoDica: "seu email",icone: Icons.email, isPassword: false,controller: _email, focusNode: _emailFocusNode,),
                          CampoEntrada(titulo: "Senha", textoDica: "sua senha",icone: Icons.lock, isPassword: true,controller: _senha, focusNode: _senhaFocusNode,),
                          SizedBox(height: 25,),
                         InkWell(                         
                            onTap: () async { 
                              if (verificaCampos())
                              {
                                Alert(context: context, title: "Login não efetuado", desc: "Por favor verifique todos os campos, apenas quando todos forem corretamente preenchidos seu login será realizado").show();
                              }
                              else{
                                //showDialog(context: context, child: Center(child: CircularProgressIndicator()));
                                
                                bool armazenado = false;        
                                var indice =  0;
                                for (Usuario item in boxUsers.values.toList()) {
                                  //showDialog(context: context, child: Center(child: CircularProgressIndicator()));
                                  if (item.email == _email.text && item.senha == _senha.text) {
                                    armazenado = true;
                                    userAuth.usuario = item;
                                    userAuth.indice = indice;
                                      
                                    
                                    showDialog(context: context, child: Center(child: CircularProgressIndicator()));
                                    return Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomePage())); 
                                  }
                                  indice++;
        
        
                                }
                                if(!armazenado){
                                  userAuth.LoginEmail(_email.text, _senha.text,context);
                                  showDialog(context: context, child: Center(child: CircularProgressIndicator()));
                                }
                                

                              }                              
                         },
                        child: Botao(conteudo: "Entrar", tamFonte: 25)
                      ) ,
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: Text('Esqueceu sua senha?\t',
                        style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(height:20),
                      Align(alignment: Alignment.bottomCenter,child: _createAccountLabel(), ),
                    ],
                    
                  ),                  
                  
                ),
                
                

              ]

            ),
          ),
        ],
      )
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
                  MaterialPageRoute(builder: (context) => RegistroPage()));
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

    bool verificaCampos()
    {
      
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