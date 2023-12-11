import 'package:asthma/helper/imports.dart';

Future<UserModel?> getUserProfile() async {
  try {
    final supabase = SupabaseNetworking().getSupabase;
    await Future.delayed(const Duration(seconds: 2));
    final userProfile = await supabase
        .from("users")
        .select()
        .eq("id_auth", supabase.auth.currentUser!.id);
    return UserModel.fromJson(userProfile[0]);
  } catch (t) {
    return null;
  }
}
