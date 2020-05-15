import 'package:avataaar_image/avataaar_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ocaviva/main.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/screens/registroPage.dart';
import 'package:ocaviva/screens/home_page.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/botao.dart';
import 'package:ocaviva/widgets/campoEntrada.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class Perfil extends  StatefulWidget{
   @override
  PerfilState createState() {
    return new PerfilState();
  }
}

Box<Usuario> boxUsers;


class PerfilState extends State<Perfil>
{
  @override
  void initState() 
  {
    super.initState();
    boxUsers = Hive.box<Usuario>('users');
  }
  final TextEditingController _nome = TextEditingController(text:userAuth.usuario.nome);
  final TextEditingController _escola = TextEditingController(text:userAuth.usuario.escola);



  FocusNode _nomeFocusNode = new FocusNode();
  FocusNode _escolaFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Texto(conteudo:"Perfil", tamFonte:18.0),
        ),
        extendBodyBehindAppBar: true,
        //extendBody: true,
 
        body: Stack(
        children: <Widget>[
          BodyBackground(), 
                            
                Container(
                  alignment: Alignment.topCenter,
                  child:
                ListView
                  (
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    children: <Widget>
                    [
                       SizedBox(height: 25,),
                      CircleAvatar(
                        radius: 50,
                        child:AvataaarImage(
                        avatar: avatar,
                        errorImage: Icon(Icons.error),
                        placeholder: CircularProgressIndicator(),
                        width: 110.0,
                        ),
                      ), 
                  
                      CampoEntrada(titulo: "OcaViva", textoDica: "o nome da ocaviva",icone: Icons.person, isPassword: false,controller: _nome, focusNode: _nomeFocusNode,),
                      SizedBox(height: 10,),
                      InkWell
                      ( 
                        onTap: () { 
                          if (verificaCampos())
                          {
                            Alert(context: context, title: "Cadastro não efetuado", desc: "Por favor verifique todos os campos, apenas quando todos forem preenchidos corretamente seu cadastrado será realizado").show();
                          }
                          else
                          {
                            showDialog(context: context, child: Center(child: CircularProgressIndicator()));
                            userAuth.usuario.nome = _nome.text;  
                            //userAuth.usuario.escola = _nome.text;
                            firestore.updateFromFirestore(userAuth.usuario);
                            var key= userAuth.usuario.email+userAuth.usuario.senha;
                            boxUsers.put(key, userAuth.usuario);
                            _nome.clear();
                            _escola.clear();
                            _nomeFocusNode.unfocus();
                            _escolaFocusNode.unfocus();
                            
                            return Navigator.pop(context); 
                                 
                          }                          
                        },
                        child: Botao(conteudo: "Atualizar nome da OcaViva", tamFonte: 18),
                      ) ,   
                       SizedBox(height: 10,),
                      CampoEntrada(titulo: "Comunidade", textoDica: "o nome da turma",icone: Icons.school, isPassword: false, controller: _escola, focusNode: _escolaFocusNode,),
                      SizedBox(height: 10,),
                      InkWell
                      ( 
                        onTap: () { 
                          if (verificaCampos())
                          {
                            Alert(context: context, title: "Cadastro não efetuado", desc: "Por favor verifique todos os campos, apenas quando todos forem preenchidos corretamente seu cadastrado será realizado").show();
                          }
                          else
                          {
                            showDialog(context: context, child: Center(child: CircularProgressIndicator()));
                            //userAuth.usuario.nome = _nome.text;  
                            userAuth.usuario.escola = _escola.text;
                            firestore.updateFromFirestore(userAuth.usuario);
                            var key= userAuth.usuario.email+userAuth.usuario.senha;
                            boxUsers.put(key, userAuth.usuario);
                            _nome.clear();
                            _escola.clear();
                            _nomeFocusNode.unfocus();
                            _escolaFocusNode.unfocus();
                            return Navigator.pop(context); 
                                 
                          }                          
                        },
                        child: Botao(conteudo: "Atualizar a comunidade", tamFonte: 18),
                      ) ,   
                    ]

                  )
                )
             
          
        ],
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
      
      return false;
      
    }
}