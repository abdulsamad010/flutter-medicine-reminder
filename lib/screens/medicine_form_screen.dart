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
      appBar: AppBar(title:Text(titleText),
        ),
      body:Form(
        key: fk,
          child: ListView(
            children: [

              if(widget.Edit==true)
                Text("Edit Medicine for ID: ${context.read<MedicineProvider>().medicines[widget.Index].id}"),

              TextFormField(
                decoration: InputDecoration(
                  label: Text("Name"),
                ),
                controller: nameCont,
                validator: nameVal,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),

              TextFormField(
                controller: personNameCont,
                decoration: const InputDecoration(
                  labelText: "Person Name",
                ),
                validator: personNameVal,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),

              TextFormField(
                controller: dosageCont,
                decoration: const InputDecoration(
                  labelText: "Dosage",
                  hintText: "e.g. 1 Tablet, 5 ml"
                ),
                validator: dosageVal,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),

              TextFormField(
                controller: reminderTimeCont,
                decoration: const InputDecoration(
                  labelText: "Reminder Time",
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

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                }}, child: Text("Submit"))

            ],

      )),
    );
  }
}
