import 'package:asthma/Models/medication_model.dart';
import 'package:asthma/Models/symptoms_model.dart';
import 'package:asthma/helper/imports.dart';

List<LocationModel> allHospetal = [];
List<MedicationModel> allMedication = [];
List<SymptomsModel> allSymptoms = [];

class SupabaseServer {
  final supabase = Supabase.instance.client;

  getHospitalData() async {
    print("i am here 1");
    final hospitalData = await supabase.from("hospitals").select();
    print("i am here 2");

    for (var element in hospitalData) {
      allHospetal.add(LocationModel.fromJson(element));
    }
    print("i am here 3");

    return allHospetal;
  }

  getMedication() async {
    final data = await supabase.from("medication").select("*");
    allMedication.clear();
    for (var element in data) {
      allMedication.add(MedicationModel.fromJson(element));
    }
    return allMedication;
  }

  getSymptoms() async {
    final data = await supabase.from("symptoms").select("*");
    allSymptoms.clear();
    for (var element in data) {
      allSymptoms.add(SymptomsModel.fromJson(element));
    }
    return allSymptoms;
  }

  addMedication(Map body) async {
    await supabase.from("medication").insert(body).select();
  }

  addSymptom(Map body) async {
    await supabase.from("symptoms").insert(body).select();
  }

  deleteMedication({required int id}) async {
    await supabase.from("medication").delete().eq('id', id);
  }

  deleteSymptom({required int id}) async {
    await supabase.from("symptoms").delete().eq('id', id);
  }
}
