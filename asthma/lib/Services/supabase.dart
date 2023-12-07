import 'package:asthma/Models/location_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
List<LocationModel> allHospetal = [];
class SupabaseServer {
  getHospitalData() async {
    final hospitalData =
        await Supabase.instance.client.from("hospitals").select();
    print(hospitalData);
    
    print(hospitalData);
    for (var element in hospitalData) {
      allHospetal.add(LocationModel.fromJson(element));
    }
    return allHospetal;
  }
}
