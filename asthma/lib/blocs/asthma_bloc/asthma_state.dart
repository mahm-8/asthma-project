part of 'asthma_bloc.dart';

@immutable
sealed class AsthmaState {}

final class AsthmaInitial extends AsthmaState {}

final class LoadingState extends AsthmaState {}

final class SuccessHospitalState extends AsthmaState {
  final List<LocationModel>? hospitalsData;

  SuccessHospitalState(this.hospitalsData);
}

final class SuccessGetSymptomState extends AsthmaState {
  final List<SymptomsModel> symptoms;

  SuccessGetSymptomState({required this.symptoms});
}

final class SuccessGetMedicationState extends AsthmaState {
  final List<MedicationModel> medications;

  SuccessGetMedicationState({required this.medications});
}

final class ChangeSymptomState extends AsthmaState {
  final String selectedSymptom;

  ChangeSymptomState(this.selectedSymptom);
}

final class ChangeLevelState extends AsthmaState {
  final String selectedLevel;

  ChangeLevelState(this.selectedLevel);
}

final class SuccessAddSymptomState extends AsthmaState {}

final class SuccessAddMedicationState extends AsthmaState {
  final String message;

  SuccessAddMedicationState({required this.message});
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
