import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';
part 'language_state.dart';

String arr = 'en';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(ChangeLanguageState(lang: arr)) {
    on<ChangeLanguage>(language);
  }

  FutureOr<void> language(ChangeLanguage event, Emitter<LanguageState> emit) {
    print(event.lang);
    if (event.lang) {
      emit(ChangeLanguageState(lang: 'en'.trim()));
      emit(SwitchState(swit: event.lang));
    } else if (event.lang == false) {
      print(2);
      emit(ChangeLanguageState(lang: 'ar'));
      emit(SwitchState(swit: event.lang));
    }
  }
}
