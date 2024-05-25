import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furrl/domain/model/image_model.dart';
import 'package:furrl/presentation/app/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(ImageModelAdapter());
  await Hive.openBox<List<ImageModel>>('images');
  runApp(const FurrlApp());
}
