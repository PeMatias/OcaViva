
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../screens/home_page.dart';
import 'Usuario.dart';

part 'firestore.g.dart';

final Firestore _firestore = Firestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class Mobxfirestore = MobxfirestoreBase with _$Mobxfirestore;

abstract class MobxfirestoreBase with Store {
  MobxfirestoreBase();

  @observable
  Usuario usuario;

  @observable
  ObservableFuture<List<Usuario>> usuarios =
      ObservableFuture<List<Usuario>>.value([]);

  @computed
  List<Usuario> get fullNamesFromFirestore => usuarios.value;

  @action
  Future<bool> getFromFirestore() async {
    List<Usuario> usuarios = List();
    var query = _firestore.collection('usuarios').getDocuments();
    await query.then((snap) {
      print('snap length: ${snap.documents.length}');

      if (snap.documents.length > 0) {
        for (var doc in snap.documents) {
          usuarios.add(Usuario.fromfirestoresnapshot(doc));
          // print('fullname docID: ${doc.documentID}');
        }

        //print('fullnames length: ${fullnames.length}');

        usuarios = ObservableFuture<List<Usuario>>.value(usuarios) as List<Usuario>;
      }
    });

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
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomePage())); 
    return user;
  }

  
}