import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ocaviva/main.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/screens/registroPage.dart';
import 'package:ocaviva/services/jogo_service.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/campoEntrada.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/botao.dart';


List<Usuario> listUsers ;

ProgressDialog pr2;


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
    /*boxUsers.deleteFromDisk();
    boxUsers.clear();
    boxUsers.close();*/
    if(!Hive.isBoxOpen("users"))
    {
      abrirCaixa();
    }
   
    userAuth.getFromFirestore();
    
    super.initState(); 
    
    
    
    
  }

  TextEditingController _email = TextEditingController(text:prefs.getString('email'));
  TextEditingController _senha = TextEditingController(text:prefs.getString('senha'));
  

  
  FocusNode _emailFocusNode = new FocusNode();
  FocusNode _senhaFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) 
  {
    //Size screenSize = MediaQuery.of(context).size;
    //double screenWidth = screenSize.width;
    ///String fraseInicial = "Olá,  \nvejo que é a sua primeira\n vez aqui\n Vamos começar!\n\n Se não possui conta, então:\n";
    
     pr2 = new ProgressDialog(context);
    if(pr2.isShowing())pr2.hide();

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
                            onTap: ()  { 
                              Box<Usuario> boxUsers = Hive.box<Usuario>('users');

                               
                              if (verificaCampos())
                              {
                                Alert(context: context, title: "Login não efetuado", desc: "Por favor verifique todos os campos, apenas quando todos forem corretamente preenchidos seu login será realizado").show();
                              }
                              else{
                               
                               
            
                              
                              //showDialog(context: this.context, child: Center(child: CircularProgressIndicator()));
                              
                              pr2.style(
                                    message: 'Aguarde,\nProcessando...',
                                    borderRadius: 10.0,
                                    backgroundColor: Colors.white,
                                    progressWidget: CircularProgressIndicator(),
                                    elevation: 10.0,
                                    insetAnimCurve: Curves.easeInOut,
                                    progress: 0.0,
                                    maxProgress: 100.0,
                                    progressTextStyle: TextStyle(
                                      color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
                                    messageTextStyle: TextStyle(
                                      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w400)
                                  );
                              
                                 pr2.show();
                              AlertDialog(semanticLabel: "Por favor, Aguarde",);
                                                           
                               Future.delayed(new Duration(seconds: 3), () async {
                                 if(boxUsers.length == 0){
                                  print("está zerado");
                                  userAuth.getFromFirestore();
                                 }
                                                                   

                              
                                
                               
                                
                                 await  userAuth.loginEmail(_email.text, _senha.text,context, pr2);
                               

                                 //log(boxUsers.get(_email.text+_senha.text).nome.toString());
                                  
                                
                                 });
                                

                              }                              
                         },
                        child: Botao(conteudo: "INICIAR", tamFonte: 25)
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

void _onLoading() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      );
    },
  );

}
    

}