import 'package:asthma/Models/user_model.dart';
import 'package:asthma/Services/supabase.dart';

Future<UserModel?> getUserProfile() async {
  try {
    final supabase = SupabaseNetworking().getSupabase;
    final userProfile = await supabase
        .from("users")
        .select()
        .eq("id_auth", supabase.auth.currentUser!.id);
    print(userProfile[0]);
    await Future.delayed(const Duration(seconds: 1));

    return UserModel.fromJson(userProfile[0]);
  } catch (t) {
    return null;
  }
}
