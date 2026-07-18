import 'package:flutter/material.dart';
import 'package:medicine_reminder/providers/medicine_provider.dart';
import 'package:provider/provider.dart';
import '../models/medicine.dart';
import '../screens/medicine_form_screen.dart';


class MedicineCard extends StatelessWidget {
  List<Medicine> medicines;
  int index;
  bool edit;
  MedicineCard({super.key, required this.medicines, required this.index, required this.edit});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
          children: [

            Container(
              decoration: BoxDecoration(
              ),
              child: Icon(Icons.medical_services_outlined,
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(medicines[index].name),
              
                      SizedBox(width: 55,),
              
                      Icon(Icons.notifications_active,color: Colors.amberAccent),
              
                      Text('${medicines[index].reminderTime}'),
              
              
              
                    ],
                  ),
              
                  Divider(thickness: 2,color: Colors.black,),
              
                  Text(
                      'Person Name: ${medicines[index].personName}\n'
                          'Dosage: ${medicines[index].dosage}\n'
                          'Created At: ${medicines[index].createdAt.substring(0,10)}\n'
                  ),
                ],
              ),
            ),

            Column(
              children: [
                IconButton(onPressed: (){
                  context.read<MedicineProvider>().deleteMedicine(medicines[index].id);
                },icon:Icon(Icons.delete)),


                IconButton(onPressed: (){
                  edit=true;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineFormScreen(Edit:edit, Index:index)));
                }, icon: Icon(Icons.edit),
                ),
              ],
            ),





    ]),);




  }
}




