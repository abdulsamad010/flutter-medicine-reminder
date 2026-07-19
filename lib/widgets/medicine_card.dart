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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          child: Row(
            children: [

               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Icon(Icons.medical_services_outlined, color: Colors.red, size: 35, ),
               ),


              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(child: Text(medicines[index].name,style: Theme.of(context).textTheme.bodyMedium,)),


                        Icon(Icons.notifications_active,color: Colors.amberAccent),

                        Text('${medicines[index].reminderTime}',style: Theme.of(context).textTheme.bodySmall),



                      ],
                    ),

                    Divider(thickness: 2,color: Colors.black,),

                    Row(
                      children: [

                        Column(children: [
                          Icon(Icons.person_outlined),
                          SizedBox(height: 16,),
                          Icon(Icons.medication_liquid),
                          SizedBox(height: 16,),
                          Icon(Icons.date_range),

                        ],),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                    '${medicines[index].personName}'
                                ,style: Theme.of(context).textTheme.bodySmall,),

                                SizedBox(height: 8,),

                                Text(
                                      '${medicines[index].dosage}'
                                  ,style: Theme.of(context).textTheme.bodySmall,),
                                SizedBox(height: 8,),

                                Text(
                                      '${medicines[index].createdAt.substring(0,10)}'
                                  ,style: Theme.of(context).textTheme.bodySmall,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  IconButton(onPressed: (){
                    context.read<MedicineProvider>().deleteMedicine(medicines[index].id);
                  },icon:Icon(Icons.delete, color: Colors.red,)),


                  IconButton(onPressed: (){
                    edit=true;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineFormScreen(Edit:edit, Index:index)));
                  }, icon: Icon(Icons.edit),
                  ),
                ],
              ),





      ]),),
    );




  }
}




