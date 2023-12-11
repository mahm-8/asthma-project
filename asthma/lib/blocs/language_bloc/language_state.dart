part of 'language_bloc.dart';

@immutable
abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class ChangeLanguageState extends LanguageState {
  final String lang;

  ChangeLanguageState({required this.lang});
}

class SwitchState extends LanguageState {
  final bool swit;

  SwitchState({required this.swit});
}
