import 'package:flutter/material.dart';
import 'package:moeda_app/configs/app_settings.dart';
import 'package:moeda_app/repositories/conta_repository.dart';
import 'package:moeda_app/repositories/favoritas_repository.dart';
import 'package:provider/provider.dart';

import 'configs/hive_config.dart';
import 'myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContaRepository()),
        ChangeNotifierProvider<AppSettings>(create: (context) => AppSettings()),
        ChangeNotifierProvider<FavoritasRepository>(
            create: (context) => FavoritasRepository()),
      ],
      child: const MyApp(),
    ),
  );
}
