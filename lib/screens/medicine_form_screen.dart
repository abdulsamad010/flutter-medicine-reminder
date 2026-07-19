import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/medicine.dart';
import '../providers/medicine_provider.dart';
import 'home_screen.dart';

class MedicineFormScreen extends StatefulWidget {

  final bool Edit;
  final Index;
  const MedicineFormScreen({super.key,required this.Edit, required this.Index});

  @override
  State<MedicineFormScreen> createState() => _MedicineFormScreenState();
}

class _MedicineFormScreenState extends State<MedicineFormScreen> {
  late Medicine medicine=Medicine(id:null, name: "", personName: "", dosage: "", reminderTime: "", createdAt: "");
  final nameCont=TextEditingController();
  final idCont=TextEditingController();
  final personNameCont = TextEditingController();
  final dosageCont = TextEditingController();
  final reminderTimeCont = TextEditingController();
  final createdAtCont = TextEditingController();
  final fk=GlobalKey<FormState>();

  String? nameVal(String? value){
    if(value==null || value.trim().isEmpty){
      return "Enter name";
    }
    return null;
  }

  String? personNameVal(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter person name";
    }
    return null;
  }

  String? dosageVal(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter dosage";
    }
    return null;
  }

  String? reminderTimeVal(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter reminder time";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    if(widget.Edit==true){
      medicine=context.read<MedicineProvider>().medicines[widget.Index];
      idCont.text=medicine.id.toString();
      nameCont.text=medicine.name;
      personNameCont.text = medicine.personName;
      dosageCont.text = medicine.dosage;
      reminderTimeCont.text = medicine.reminderTime;
      createdAtCont.text = medicine.createdAt;

  }
}
  @override
  Widget build(BuildContext context) {
    var titleText="Add New Medicine";
    if(widget.Edit==true) {
      titleText="Edit Existing Medicine";
    }
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(
        color: Colors.white
      ),title:Text(titleText,style: Theme.of(context).textTheme.bodyLarge,),backgroundColor: Colors.blue,
        ),
      body:Form(
        key: fk,
          child: ListView(

            padding: EdgeInsets.all(8),
            children: [

              if(widget.Edit==true)
                Center(child: Text("Edit Medicine for ID: ${context.read<MedicineProvider>().medicines[widget.Index].id}",)),

              SizedBox(height: 8,),

              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.medication,color: Colors.blue,),
                  label: Text("Medicine Name",style: Theme.of(context).textTheme.bodyMedium),
                ),
                controller: nameCont,
                validator: nameVal,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: personNameCont,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.person_outlined,color: Colors.blue,),
                  label: Text("Person Name",style: Theme.of(context).textTheme.bodyMedium),
                ),
                validator: personNameVal,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: dosageCont,
                decoration:InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.medication_liquid,color: Colors.blue,),
                  label: Text("Dosage",style: Theme.of(context).textTheme.bodyMedium),
                  hint: Text("e.g. 1 Tablet, 5 ml",style: Theme.of(context).textTheme.bodySmall),
                ),
                validator: dosageVal,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: reminderTimeCont,
                decoration:InputDecoration(
                  icon: Icon(Icons.watch_later,color: Colors.blue,),
                  label: Text("Daily Reminder Time",style: Theme.of(context).textTheme.bodyMedium),
                ),
                  readOnly: true,
                onTap: () async{
                  TimeOfDay? time = await showTimePicker(context: context,
                      initialTime: TimeOfDay.now()
                  );
                  if (time != null) {
                    reminderTimeCont.text = time.format(context);
                  }
                },
                validator: reminderTimeVal,
              ),


              SizedBox(height: 8,),
              ElevatedButton(onPressed: (){
                if(fk.currentState!.validate()){
                medicine.name=nameCont.text;
                medicine.personName = personNameCont.text;
                medicine.dosage = dosageCont.text;
                medicine.reminderTime = reminderTimeCont.text;
                medicine.createdAt = DateTime.now().toString();
                if(widget.Edit==true){
                  context.read<MedicineProvider>().updateMedicine(medicine);
                }
                if(widget.Edit==false){
                  context.read<MedicineProvider>().addMedicine(medicine);
                }

                Navigator.pop(context);
                }}, child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 20)),)

            ],

      )),
    );
  }
}
