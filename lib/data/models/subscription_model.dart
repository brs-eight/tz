import 'package:hive/hive.dart';
import '../../domain/entity/subscription_entity.dart';

class SubscriptionModel extends HiveObject implements ISubscription {
  @override
  @HiveField(0)
  final String name;
  @override
  @HiveField(1)
  final String price;
  @override
  @HiveField(2)
  final String duration;

  SubscriptionModel({
    required this.name,
    required this.price,
    required this.duration,
  });
}

class SubscriptionModelAdapter extends TypeAdapter<SubscriptionModel> {
  @override
  final int typeId = 0;

  @override
  SubscriptionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubscriptionModel(
      name: fields[0] as String,
      price: fields[1] as String,
      duration: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SubscriptionModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
