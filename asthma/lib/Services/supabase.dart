import 'package:asthma/Models/location_model.dart';
import 'package:asthma/Models/medication_model.dart';
import 'package:asthma/Models/symptoms_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

List<LocationModel> allHospetal = [];

class SupabaseServer {
  final supabase = Supabase.instance.client;

  getHospitalData() async {
    final hospitalData = await supabase.from("hospitals").select();
    print(hospitalData);

    print(hospitalData);
    for (var element in hospitalData) {
      allHospetal.add(LocationModel.fromJson(element));
    }
    return allHospetal;
  }

  Future<List<MedicationModel>> getMedication() async {
    final data = await supabase.from("medication").select("*");
    print(data);
    List<MedicationModel> medicationsList = [];
    for (var element in data) {
      medicationsList.add(MedicationModel.fromJson(element));
    }
    return medicationsList;
  }

  Future<List<SymptomsModel>> getSymptoms() async {
    final data = await supabase.from("symptoms").select("*");
    print(data);
    List<SymptomsModel> symptomsList = [];
    for (var element in data) {
      symptomsList.add(SymptomsModel.fromJson(element));
    }
    return symptomsList;
  }

  addMedication(Map body) async {
    await supabase.from("medication").insert(body).select();
  }

  addSymptom(Map body) async {
    await supabase.from("symptoms").insert(body).select();
  }
}
