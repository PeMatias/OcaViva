// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Mobxfirestore on MobxfirestoreBase, Store {
  Computed<List<Usuario>> _$fullNamesFromFirestoreComputed;

  @override
  List<Usuario> get fullNamesFromFirestore =>
      (_$fullNamesFromFirestoreComputed ??=
              Computed<List<Usuario>>(() => super.fullNamesFromFirestore))
          .value;
  Computed<List<Usuario>> _$fullUsuariosLocaisComputed;

  @override
  List<Usuario> get fullUsuariosLocais => (_$fullUsuariosLocaisComputed ??=
          Computed<List<Usuario>>(() => super.fullUsuariosLocais))
      .value;
  Computed<bool> _$updatedLoginStatusComputed;

  @override
  bool get updatedLoginStatus => (_$updatedLoginStatusComputed ??=
          Computed<bool>(() => super.updatedLoginStatus))
      .value;

  final _$usuarioAtom = Atom(name: 'MobxfirestoreBase.usuario');

  @override
  Usuario get usuario {
    _$usuarioAtom.context.enforceReadPolicy(_$usuarioAtom);
    _$usuarioAtom.reportObserved();
    return super.usuario;
  }

  @override
  set usuario(Usuario value) {
    _$usuarioAtom.context.conditionallyRunInAction(() {
      super.usuario = value;
      _$usuarioAtom.reportChanged();
    }, _$usuarioAtom, name: '${_$usuarioAtom.name}_set');
  }

  final _$usuariosAtom = Atom(name: 'MobxfirestoreBase.usuarios');

  @override
  ObservableFuture<List<Usuario>> get usuarios {
    _$usuariosAtom.context.enforceReadPolicy(_$usuariosAtom);
    _$usuariosAtom.reportObserved();
    return super.usuarios;
  }

  @override
  set usuarios(ObservableFuture<List<Usuario>> value) {
    _$usuariosAtom.context.conditionallyRunInAction(() {
      super.usuarios = value;
      _$usuariosAtom.reportChanged();
    }, _$usuariosAtom, name: '${_$usuariosAtom.name}_set');
  }

  final _$usuariosLocaisAtom = Atom(name: 'MobxfirestoreBase.usuariosLocais');

  @override
  ObservableFuture<List<Usuario>> get usuariosLocais {
    _$usuariosLocaisAtom.context.enforceReadPolicy(_$usuariosLocaisAtom);
    _$usuariosLocaisAtom.reportObserved();
    return super.usuariosLocais;
  }

  @override
  set usuariosLocais(ObservableFuture<List<Usuario>> value) {
    _$usuariosLocaisAtom.context.conditionallyRunInAction(() {
      super.usuariosLocais = value;
      _$usuariosLocaisAtom.reportChanged();
    }, _$usuariosLocaisAtom, name: '${_$usuariosLocaisAtom.name}_set');
  }

  final _$logInAtom = Atom(name: 'MobxfirestoreBase.logIn');

  @override
  bool get logIn {
    _$logInAtom.context.enforceReadPolicy(_$logInAtom);
    _$logInAtom.reportObserved();
    return super.logIn;
  }

  @override
  set logIn(bool value) {
    _$logInAtom.context.conditionallyRunInAction(() {
      super.logIn = value;
      _$logInAtom.reportChanged();
    }, _$logInAtom, name: '${_$logInAtom.name}_set');
  }

  final _$logOutAtom = Atom(name: 'MobxfirestoreBase.logOut');

  @override
  bool get logOut {
    _$logOutAtom.context.enforceReadPolicy(_$logOutAtom);
    _$logOutAtom.reportObserved();
    return super.logOut;
  }

  @override
  set logOut(bool value) {
    _$logOutAtom.context.conditionallyRunInAction(() {
      super.logOut = value;
      _$logOutAtom.reportChanged();
    }, _$logOutAtom, name: '${_$logOutAtom.name}_set');
  }

  final _$loginStatusAtom = Atom(name: 'MobxfirestoreBase.loginStatus');

  @override
  ObservableFuture<bool> get loginStatus {
    _$loginStatusAtom.context.enforceReadPolicy(_$loginStatusAtom);
    _$loginStatusAtom.reportObserved();
    return super.loginStatus;
  }

  @override
  set loginStatus(ObservableFuture<bool> value) {
    _$loginStatusAtom.context.conditionallyRunInAction(() {
      super.loginStatus = value;
      _$loginStatusAtom.reportChanged();
    }, _$loginStatusAtom, name: '${_$loginStatusAtom.name}_set');
  }

  final _$getFromFirestoreAsyncAction = AsyncAction('getFromFirestore');

  @override
  Future<bool> getFromFirestore() {
    return _$getFromFirestoreAsyncAction.run(() => super.getFromFirestore());
  }

  final _$delFromFirestoreAsyncAction = AsyncAction('delFromFirestore');

  @override
  Future<bool> delFromFirestore(Usuario usuario) {
    return _$delFromFirestoreAsyncAction
        .run(() => super.delFromFirestore(usuario));
  }

  final _$updateFromFirestoreAsyncAction = AsyncAction('updateFromFirestore');

  @override
  Future<bool> updateFromFirestore(Usuario usuario) {
    return _$updateFromFirestoreAsyncAction
        .run(() => super.updateFromFirestore(usuario));
  }

  final _$pushToFirestoreAsyncAction = AsyncAction('pushToFirestore');

  @override
  Future<bool> pushToFirestore(Usuario usuario) {
    return _$pushToFirestoreAsyncAction
        .run(() => super.pushToFirestore(usuario));
  }

  final _$MobxfirestoreBaseActionController =
      ActionController(name: 'MobxfirestoreBase');

  @override
  void changeLoginStatus(dynamic status) {
    final _$actionInfo = _$MobxfirestoreBaseActionController.startAction();
    try {
      return super.changeLoginStatus(status);
    } finally {
      _$MobxfirestoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logoutAccount(BuildContext context, String routeName) {
    final _$actionInfo = _$MobxfirestoreBaseActionController.startAction();
    try {
      return super.logoutAccount(context, routeName);
    } finally {
      _$MobxfirestoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
