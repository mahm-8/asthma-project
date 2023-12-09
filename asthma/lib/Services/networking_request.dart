import 'package:asthma/Models/user_model.dart';
import 'networking_api.dart';

Future<UserModel?> getUserProfile() async {
  try {
    final supabase = SupabaseNetworking().getSupabase;
    // await Future.delayed(const Duration(seconds: 5));
    final userProfile = await supabase
        .from("users")
        .select()
        .eq("id_auth", supabase.auth.currentUser!.id);
    // print(userProfile[0]);
    return UserModel.fromJson(userProfile[0]);
  } catch (t) {
    return null;
  }
}
