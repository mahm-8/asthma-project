import 'package:asthma/helper/imports.dart';
import 'package:asthma/main.dart';
part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc()
      : super(ChangeLanguageState(lang: prefs.getString("language") ?? "ar")) {
    on<ChangeLanguage>(language);
  }

  FutureOr<void> language(
      ChangeLanguage event, Emitter<LanguageState> emit) async {
    if (event.lang) {
      emit(ChangeLanguageState(lang: 'en'));
      emit(SwitchState(swit: event.lang));
      prefs.setString("language", 'en');
    } else if (event.lang == false) {
      emit(ChangeLanguageState(lang: 'ar'));
      emit(SwitchState(swit: event.lang));
      prefs.setString("language", 'ar');
    }
  }
}
