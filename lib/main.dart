import 'package:flutter/material.dart';
import 'package:moeda_app/configs/app_settings.dart';
import 'package:moeda_app/repositories/favoritas_repository.dart';
import 'package:provider/provider.dart';

import 'myapp.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppSettings>(create: (context) => AppSettings()),
        ChangeNotifierProvider<FavoritasRepository>(
            create: (context) => FavoritasRepository()),
      ],
      child: const MyApp(),
    ),
  );
}
