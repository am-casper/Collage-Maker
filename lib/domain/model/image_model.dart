import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'image_model.g.dart';

@HiveType(typeId: 0)
class ImageModel extends Equatable {
  @HiveField(0)
  final String url;
  @HiveField(1)
  final double positionX;
  @HiveField(2)
  final double positionY;
  @HiveField(3)
  final double scale;

  const ImageModel({ required this.url, required this.positionX, required this.positionY, required this.scale });

  @override
  List<Object?> get props => [ url];
}
