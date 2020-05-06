
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:ocaviva/screens/home_page.dart';
import 'package:ocaviva/services/jogo_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'usuario.dart';

part 'firestore.g.dart';

final Firestore _firestore = Firestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

Box<Usuario> boxUsers; 

class Mobxfirestore = MobxfirestoreBase with _$Mobxfirestore;

abstract class MobxfirestoreBase with Store {

  MobxfirestoreBase();

  @observable
  Usuario usuario;

  int indice;

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
    boxUsers = Hive.box<Usuario>('users');

    List<Usuario> usuarios_aux = List<Usuario>();
    //List<Usuario> usuarios_aux = <Usuario>[];
   
    var query = _firestore.collection('usuarios').getDocuments();
    await query.then((snap) {
      print('snap length ==: ${snap.documents.length}');

      if (snap.documents.length > 0) {
        for (var doc in snap.documents) {
          usuarios_aux.add(Usuario.fromfirestoresnapshot(doc));
          //print('fullname docID: ${doc.documentID}');
          //print('fullname data: ${doc.data}');
        }

        //print('fullnames length: ${fullnames.length}');

        usuarios = ObservableFuture<List<Usuario>>.value(usuarios_aux);

       //boxUsers
       var list = Iterable<int>.generate(boxUsers.length).toList();
        print("Tamanho box "+ boxUsers.length.toString());
       if(fullNamesFromFirestore.length != boxUsers.length)
       {
         boxUsers.deleteAll(list);
         boxUsers.clear();
       }
       print("Tamanho box values  "+ boxUsers.values.length.toString());
       if(boxUsers.isEmpty)
       {
         boxUsers.addAll(fullNamesFromFirestore);
       }
       print("Tamanho box values  "+ boxUsers.values.length.toString());
       
      }
    });
    print("Fulname tam: "+fullNamesFromFirestore.length.toString());
    print("Tamanho usuarios  "+ usuarios.value.length.toString());
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
    }
    return Future.value(true);
  }

  Future<FirebaseUser> CadastraEmail(Usuario usuario) async
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
        break;
      case "ERROR_WRONG_PASSWORD":
        errorMessage = "Sua senha está errada.";
        break;
      case "ERROR_USER_NOT_FOUND":
        errorMessage = "Não existe usuário cadastrado com esse email.";
        break;
      case "ERROR_USER_DISABLED":
        errorMessage = "Usuário com este email foi desativado.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        errorMessage = "Muitas requisições. Por favor tenta mais tarde.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        errorMessage = "Login com email e senha não autorizados.";
        break;
      default:
        errorMessage = "Um erro desconhecido ocorreu, desculpe pelo incoveniente.";
    }
  }
   

    assert (user != null);
    assert (await user.getIdToken() != null);

    return user;
  }

  Future<FirebaseUser> LoginEmail(email, senha,BuildContext context) async
  {
    String errorMessage;
    FirebaseUser user;

    try {
      AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: senha);
      user = result.user;

    } catch (error) {
    switch (error.code) {
      case "ERROR_INVALID_EMAIL":
        errorMessage = "O seu endereço de email parece estar incorreto.";
        Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
        break;
      case "ERROR_WRONG_PASSWORD":
        errorMessage = "Sua senha está errada.";
        Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
        break;
      case "ERROR_USER_NOT_FOUND":
        errorMessage = "Não existe usuário cadastrado com esse email.";
        Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
        break;
      case "ERROR_USER_DISABLED":
        errorMessage = "Usuário com este email foi desativado.";
        Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        errorMessage = "Muitas requisições. Por favor tenta mais tarde.";
        Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        errorMessage = "Login com email e senha não autorizados.";
        Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
        break;
      default:
        errorMessage = "Um erro desconhecido ocorreu, desculpe pelo incoveniente.";
        Alert(context: context, title: "Login não efetuado", desc:errorMessage).show();
    }
  }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
     assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);
    print('Login sucesso: $user');
    loginStatus = ObservableFuture.value(true);
    getFromFirestore();
    var indice =  0;
                                
    for (Usuario item in fullNamesFromFirestore) {
      if (item.email == email && item.senha == senha) {
        print("esse é o indice:"+indice.toString());
        this.usuario = item;
        this.indice = indice;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', this.usuario.email);
        prefs.setString('senha', this.usuario.senha);
          
        break;
      }
      indice++;


    }
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomePage())); 
    return user;
  }

    @action
  Future<bool> logoutAccount() async {
    auth.signOut();
    print('Google logged out');
    loginStatus = ObservableFuture.value(false);
    return await Future.value(true);
  }

  
}