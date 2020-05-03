// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsuarioAdapter extends TypeAdapter<Usuario> {
  @override
  final typeId = 1;

  @override
  Usuario read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Usuario(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[5] as String,
      fields[6] as bool,
    )
      ..documentID = fields[7] as String
      ..score = (fields[8] as List)?.cast<dynamic>()
      ..desempenho = (fields[9] as List)?.cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, Usuario obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.escola)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.senha)
      ..writeByte(6)
      ..write(obj.aluno)
      ..writeByte(7)
      ..write(obj.documentID)
      ..writeByte(8)
      ..write(obj.score)
      ..writeByte(9)
      ..write(obj.desempenho);
  }
}
