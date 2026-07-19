import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/medicine_provider.dart';
import '../widgets/medicine_card.dart';
import 'about_app.dart';
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
        appBar: AppBar(title: Center(child: Text('Medicine Reminder', style: Theme.of(context).textTheme.bodyLarge,)),backgroundColor: Colors.blue,),

        floatingActionButton: FloatingActionButton(onPressed: (){
          edit=false;
          Navigator.push(context,MaterialPageRoute(builder: (context)=>MedicineFormScreen(Edit: edit, Index: null)));
        },child: Icon(Icons.add,color: Colors.white,),backgroundColor: Colors.blue,),

        body: Consumer<MedicineProvider>(
            builder: (context,provider,child) {
              if (provider.isLoading == true) {
                return Center(child: CircularProgressIndicator());
              }
              if(provider.medicines.isEmpty){
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Text("Empty!! Please First Add a New Medicine By Clicking")),
                      Icon(Icons.add,size: 55,)
                    ],
                  )),
                );
              }

              return ListView.builder(
                itemCount: provider.medicines.length,
                itemBuilder: (context,index){
                  return MedicineCard(medicines: provider.medicines, index:index, edit:edit);
                },
              );

            }
        ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (int index){
          if(index==1){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutApp()));
          }
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.blue,),label: "Home"),
        BottomNavigationBarItem(label:"About",icon: Icon(Icons.medical_information_rounded,color: Colors.blue,))
      ],),
    );
  }
}
