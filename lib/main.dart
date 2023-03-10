import 'package:flutter/material.dart';
import 'package:moeda_app/repositories/favoritas_repository.dart';
import 'package:provider/provider.dart';

import 'myapp.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritasRepository(),
      child: const MyApp(),
    ),
  );
}
