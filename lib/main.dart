import 'package:flutter/material.dart';
import 'package:medicine_reminder/providers/medicine_provider.dart';
import 'package:medicine_reminder/screens/home_screen.dart';
import 'package:medicine_reminder/services/notification_service.dart';
import 'package:provider/provider.dart';

void main() async {


  runApp(
    ChangeNotifierProvider(
      create: (context){
        return MedicineProvider();
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomeScreen(),
    );
  }
}
