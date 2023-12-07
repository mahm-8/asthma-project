part of 'asthma_bloc.dart';

@immutable
sealed class AsthmaState {}

final class AsthmaInitial extends AsthmaState {}

final class LoadingState extends AsthmaState {}

final class SuccessHospitalState extends AsthmaState {
}

final class ErrorState extends AsthmaState {}
