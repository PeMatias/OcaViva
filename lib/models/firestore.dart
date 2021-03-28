
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:ocaviva/main.dart';
import 'package:ocaviva/screens/home_page.dart';
import 'package:ocaviva/screens/perfil.dart';
import 'package:ocaviva/services/jogo_service.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'usuario.dart';

part 'firestore.g.dart';

final Firestore _firestore = Firestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

Box<Usuario> boxUsers = Hive.box<Usuario>('users'); 

class Mobxfirestore = MobxfirestoreBase with _$Mobxfirestore;

abstract class MobxfirestoreBase with Store {

  MobxfirestoreBase();

  @observable
  Usuario usuario;

  int indice;

  FirebaseUser user;

  @observable
  ObservableFuture<List<Usuario>> usuarios =
      ObservableFuture<List<Usuario>>.value([]);

  @observable
  ObservableFuture<List<Usuario>> usuariosLocais =
      ObservableFuture<List<Usuario>>.value([]);

  @computed
  List<Usuario> get fullNamesFromFirestore => usuarios.value;

  @computed
  List<Usuario> get fullUsuariosLocais => usuariosLocais.value;

   @observable
  bool logIn = false;

  @observable
  bool logOut = false;

  @observable
  ObservableFuture<bool> loginStatus = ObservableFuture<bool>.value(false);

  @action
  void changeLoginStatus(dynamic status) {
    loginStatus = status;
  }

  @computed
  bool get updatedLoginStatus => loginStatus.value;
  
  @action
  Future<bool> getFromFirestore() async {
    if(!Hive.isBoxOpen("users") )
      await abrirCaixa();
    List<Usuario> usuariosAux = List<Usuario>();
    //List<Usuario> usuarios_aux = <Usuario>[];
   
    var query = _firestore.collection('usuarios').getDocuments();
    await query.then((snap) {
      print('snap length ==: ${snap.documents.length}');

      if (snap.documents.length > 0) {
        for (var doc in snap.documents) {
          usuariosAux.add(Usuario.fromfirestoresnapshot(doc));
          //print('fullname docID: ${doc.documentID}');
          //print('fullname data: ${doc.data}');
        }

        //print('fullnames length: ${fullnames.length}');

        usuarios = ObservableFuture<List<Usuario>>.value(usuariosAux);
      }
       
    });
     if(usuariosAux!= null){
        boxUsers = Hive.box<Usuario>('users'); 
     
        for (var item in usuariosAux) {
          var key =  item.email.toString() + item.senha.toString();
          try {
            boxUsers.put(key, item);
            
          } catch (e) {
          }
        }
    }
       
      


    return Future.value(true);
  }

 
  @action
  Future<bool> delFromFirestore(Usuario usuario) async {
    if (usuario != null) {
      _firestore.collection('usuarios').document(usuario.documentID).delete();
    }

    return Future.value(true);
  }
  @action
  Future<bool> updateFromFirestore(Usuario usuario) async {
    if (usuario != null) {
      _firestore.collection('usuarios').document(usuario.documentID).updateData(usuario.toJson());
    }

    return Future.value(true);
  }

  @action
  Future<bool> pushToFirestore(Usuario usuario) async {
    if (usuario != null) {
      _firestore.collection('usuarios').add(usuario.toJson());
      boxUsers = Hive.box<Usuario>('users'); 
      var key =  usuario.email.toString() + usuario.senha.toString();
      try {
            boxUsers.put(key, usuario);
            
       }catch (e) {
      }

    }
    return Future.value(true);
  }

  Future<bool> cadastraEmail(Usuario usuario) async
  {
    String errorMessage;
    FirebaseUser user;
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(email: usuario.email, password: usuario.senha);
      user = result.user;
      
    } catch (error) {
    switch (error.code) {
      case "ERROR_INVALID_EMAIL":
        errorMessage = "O seu endereço de email parece estar incorreto.";
        return false;
        break;
      case "ERROR_WRONG_PASSWORD":
        errorMessage = "Sua senha está errada.";
        return false;
        break;
      case "ERROR_USER_NOT_FOUND":
        errorMessage = "Não existe usuário cadastrado com esse email.";
        return false;
        break;
      case "ERROR_USER_DISABLED":
        errorMessage = "Usuário com este email foi desativado.";
        return false;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        errorMessage = "Muitas requisições. Por favor tenta mais tarde.";
        return false;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        errorMessage = "Login com email e senha não autorizados.";
        return false;
        break;
      default:
        errorMessage = "Um erro desconhecido ocorreu, desculpe pelo incoveniente.";
    }
  }
     if (errorMessage != null) {
      //return Future.error(errorMessage);
      return false;
    }
   

    assert (user != null);
    assert (await user.getIdToken() != null);

    this.user = user;
    print("Esse é o user: " + user.toString());
    return true;
  }


  Future loginEmail(String email,String senha,BuildContext context, ProgressDialog pr) async
  {
   
    String errorMessage;
    FirebaseUser user;
     
      //

    try {
      userAuth.getFromFirestore();
      //AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: senha);
      //user = result.user;


    } catch (error) {
    switch (error.code) {
      case "ERROR_INVALID_EMAIL":
        errorMessage = "O seu endereço de email parece estar incorreto.";
        return Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
        break;
      case "ERROR_WRONG_PASSWORD":
        errorMessage = "Sua senha está errada.";
        return Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
        break;
      case "ERROR_USER_NOT_FOUND":
        errorMessage = "Não existe usuário cadastrado com esse email.";
        return Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
        break;
      case "ERROR_USER_DISABLED":
        errorMessage = "Usuário com este email foi desativado.";
        return Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        errorMessage = "Muitas requisições. Por favor tenta mais tarde.";
        return Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        errorMessage = "Login com email e senha não autorizados.";
        return Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
        break;
      default:
        errorMessage = "Um erro desconhecido ocorreu, desculpe pelo incoveniente.";
        return Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
    }
  }
    
    //assert(await user.getIdToken() != null);
    //final FirebaseUser currentUser = await auth.currentUser();
    //assert(user.uid == currentUser.uid);
    //print('Login sucesso: $user');
    log("entrei");
    for (var item in boxUsers.keys) {

    if( item.toString().contains(email.toString()))
    {
                  

      
      var key = email.toString()+senha.toString();
      if(boxUsers.get(key)!= null)
      {
        this.usuario = boxUsers.get(key);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', this.usuario.email);
        prefs.setString('senha', this.usuario.senha);
        prefs.setBool('logado', true);
        log(this.usuario.email);
        loginStatus = ObservableFuture.value(true);
        pr.hide();
        return Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomePage())); 
        
      }
      else{
        pr.hide();
        
        return Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();

      }

    }
    }

    pr.hide();
     errorMessage = "Não existe usuário cadastrado com esse email.";
    return Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
   


    
    //this.user = user;
    //log("Esse é o user: " + user.email.toString() );
    
    
  }

    @action
    void logoutAccount(BuildContext context, String routeName)  {
    auth.signOut();
    print('Google logged out');
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logado', false);
    loginStatus = ObservableFuture.value(false);
    Navigator.pushReplacementNamed(context, routeName);
  }

  
}