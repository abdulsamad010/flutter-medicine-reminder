import 'package:flutter/cupertino.dart';
import 'package:medicine_reminder/models/medicine.dart';
import 'package:medicine_reminder/services/notification_service.dart';

import '../database/database_helper.dart';


class MedicineProvider extends ChangeNotifier{
  List<Medicine> medicines=[];
  bool isLoading=false;
  DatabaseHelper db=DatabaseHelper();
  NotificationService nS=NotificationService();

  Future<void> loadMedicine() async{
    isLoading=true;
    medicines=await db.getMedicine();
    isLoading=false;
    notifyListeners();
  }

  Future<void> addMedicine(Medicine medicine) async{
    final id=await db.insertMedicine(medicine);
    medicine.id=id;
    medicines.add(medicine);

    await nS.scheduleMedicineNotification(
      id: medicine.id!,
      medicineName: medicine.name,
      reminderTime: medicine.reminderTime,
    );

    notifyListeners();
  }

  Future<void> updateMedicine(Medicine medicine) async{
    await db.updateMedicine(medicine);
    medicines.add(medicine);
    for(int i=0;i<medicines.length;i++){
      if(medicines[i].id==medicine.id){
        medicines[i]=medicine;
        break;
      }
    }

    await nS.cancelNotification(medicine.id!);

    await nS.scheduleMedicineNotification(
      id: medicine.id!,
      medicineName: medicine.name,
      reminderTime: medicine.reminderTime,
    );

    notifyListeners();
  }

  Future<void> deleteMedicine(int? id) async{
    await db.deleteMedicine(id!);
    for (int i = 0; i < medicines.length; i++) {
      if (medicines[i].id == id) {
        medicines.removeAt(i);
        break;
      }
    }

    await nS.cancelNotification(id);

    notifyListeners();
  }
}