import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  String? arr;
  LanguageBloc() : super(LanguageInitial()) {
    on<ChangeLanguage>(language);
  }

  FutureOr<void> language(
      ChangeLanguage event, Emitter<LanguageState> emit) async {
    if (event.lang) {
      emit(ChangeLanguageState(lang: 'en'));
      emit(SwitchState(swit: event.lang));
    } else if (event.lang == false) {
      emit(ChangeLanguageState(lang: 'ar'));
      emit(SwitchState(swit: event.lang));
    }

    ;
  }
}
