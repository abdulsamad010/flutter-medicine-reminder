import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(
          color: Colors.white
      ),title:Center(child: Text("About App",style: Theme.of(context).textTheme.bodyLarge,)),backgroundColor: Colors.blue),
      body: Padding(padding: EdgeInsets.all(8),
      child: Card(
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                style: Theme.of(context).textTheme.bodySmall,
                "Medicine Reminder is a simple and easy-to-use app that helps you remember to take your medicines on time.\n\n"
                    "You can add medicines, set reminder times, and manage your medication schedule for yourself or your family members.\n\n"
                    "Your medicine information is stored only on your device, and no internet connection is required to use the app.\n\n",
                textAlign: TextAlign.justify,
              ),

              Text("Stay healthy. Stay on time. 💙")
            ],
          ),
        ),
        
      ),
    ));
  }
}

