import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/store/bloc/store_bloc.dart';
import 'features/store/data/sample_store.dart';
import 'features/store/presentation/store_detail_screen.dart';

void main() {
  runApp(const KuickoApp());
}

class KuickoApp extends StatelessWidget {
  const KuickoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuicko · Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE84242),
          primary: const Color(0xFFE84242),
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
      ),
      home: BlocProvider(
        create: (_) => StoreBloc(store: sampleStore),
        child: const StoreDetailScreen(),
      ),
    );
  }
}
