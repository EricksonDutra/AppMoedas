import 'package:hive/hive.dart';

import '../models/moeda.dart';

class MoedaHiveAdapter extends TypeAdapter<Moeda> {
  @override
  final typeId = 0;

  @override
  Moeda read(BinaryReader reader) {
    return Moeda(
      nome: reader.readString(),
      sigla: reader.readString(),
      preco: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Moeda obj) {
    writer.writeString(obj.nome);
    writer.writeString(obj.sigla);
    writer.writeDouble(obj.preco);
  }
}
