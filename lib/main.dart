import 'package:flutter/material.dart';
import 'package:medicine_reminder/providers/medicine_provider.dart';
import 'package:medicine_reminder/screens/home_screen.dart';
import 'package:medicine_reminder/services/notification_service.dart';
import 'package:provider/provider.dart';

void main() async {

    NotificationService nS=NotificationService();
    WidgetsFlutterBinding.ensureInitialized();

    await nS.initialize();
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
      theme: ThemeData(
        useMaterial3: true,
        iconTheme: IconThemeData(
          color: Colors.blue,
          size: 24
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            color: Colors.black,
            fontSize: 15,
          )
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          )
        )
      ),
    );
  }
}
