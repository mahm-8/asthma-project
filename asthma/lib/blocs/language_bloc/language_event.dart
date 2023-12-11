part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent {}

class ChangeLanguage extends LanguageEvent {
  final bool lang;

  ChangeLanguage(this.lang);
}
