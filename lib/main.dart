import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wet_areas_screen.dart';
import 'wet_areas_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WetAreasBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wet Areas UI',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: WetAreasScreen(),
      ),
    );
  }
}
