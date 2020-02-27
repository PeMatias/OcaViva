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

  final _$pushToFirestoreAsyncAction = AsyncAction('pushToFirestore');

  @override
  Future<bool> pushToFirestore(Usuario usuario) {
    return _$pushToFirestoreAsyncAction
        .run(() => super.pushToFirestore(usuario));
  }
}
