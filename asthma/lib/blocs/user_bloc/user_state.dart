part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class LoadState extends UserState {}

class ErrorState extends UserState {}
