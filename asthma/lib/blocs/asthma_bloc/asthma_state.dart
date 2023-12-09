part of 'asthma_bloc.dart';

@immutable
sealed class AsthmaState {}

final class AsthmaInitial extends AsthmaState {}

final class LoadingState extends AsthmaState {}

final class SuccessHospitalState extends AsthmaState {}

final class SuccessGetSymptomState extends AsthmaState {
  final List<SymptomsModel> symptoms;

  SuccessGetSymptomState({required this.symptoms});
}

final class SuccessGetMedicationState extends AsthmaState {
  final List<MedicationModel> medications;

  SuccessGetMedicationState({required this.medications});
}

final class SuccessAddSymptomState extends AsthmaState {}

final class SuccessAddMedicationState extends AsthmaState {}

final class SuccessDeleteState extends AsthmaState {
  
}


final class SucsessMessageState extends AsthmaState {
  final String message;

  SucsessMessageState({required this.message});
}

final class ADDErrorState extends AsthmaState {
  final String message;

  ADDErrorState({required this.message});
}

final class ErrorGetState extends AsthmaState {
  final String message;

  ErrorGetState({required this.message});
}

final class ErrorState extends AsthmaState {}
