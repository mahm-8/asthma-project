import 'dart:async';

import 'package:asthma/main.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  String? arr;
  LanguageBloc()
      : super(ChangeLanguageState(lang: prefs.getString("language") ?? 'en')) {
    on<ChangeLanguage>(language);
  }

  FutureOr<void> language(
      ChangeLanguage event, Emitter<LanguageState> emit) async {
    if (event.lang) {
      arr = 'en';
    } else if (event.lang == false) {
      arr = 'ar';
    }
    emit(SwitchState(swit: event.lang));
    emit(ChangeLanguageState(lang: arr!));
    await prefs.setString("language", arr!);
  }
}
