import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twogether_front/configs/app_routing.dart';
import 'package:twogether_front/controllers/profiles_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfilesController(),
        ),
      ],
      child: MaterialApp(
        title: 'Twogether',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: MyAppRouting().routes,
      ),
    );
  }
}
