import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/medicine_provider.dart';
import '../services/notification_service.dart';
import '../widgets/medicine_card.dart';
import 'medicine_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool edit=false;

  @override
  void initState() {
    super.initState();

    context.read<MedicineProvider>().loadMedicine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Medicine Reminder')),

        floatingActionButton: FloatingActionButton(onPressed: (){
          edit=false;
          Navigator.push(context,MaterialPageRoute(builder: (context)=>MedicineFormScreen(Edit: edit, Index: null)));
        },child: Icon(Icons.add)),

        body: Consumer<MedicineProvider>(
            builder: (context,provider,child) {
              if (provider.isLoading == true) {
                return CircularProgressIndicator();
              }
              if(provider.medicines.isEmpty){
                return Text("No medicine added yet");
              }

              return ListView.builder(
                itemCount: provider.medicines.length,
                itemBuilder: (context,index){
                  return MedicineCard(medicines: provider.medicines, index:index, edit:edit);
                },
              );

            }
        )
    );
  }
}
