import 'package:flutter/material.dart';
import 'package:furrl/presentation/app/bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furrl/presentation/home/home_screen.dart';


class FurrlApp extends StatefulWidget {
  const FurrlApp({super.key});

  @override
  State<FurrlApp> createState() => _FurrlAppState();
}

class _FurrlAppState extends State<FurrlApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Furrl',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              useMaterial3: true,
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
