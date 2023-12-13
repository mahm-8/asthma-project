part of 'asthma_bloc.dart';

@immutable
sealed class AsthmaEvent {}

class getHospitalDataEvent extends AsthmaEvent {}

class GetSymptomDataEvent extends AsthmaEvent {}

class GetMedicationDataEvent extends AsthmaEvent {}

class AddSymptomEvent extends AsthmaEvent {
  final String symptomName, symtomDetails, symptomIntensity;

  AddSymptomEvent(this.symptomName, this.symtomDetails, this.symptomIntensity);
}

class AddMedicationEvent extends AsthmaEvent {
  final String medicationName, date;
  final int? days;

  AddMedicationEvent(this.medicationName, this.days, this.date);
}

class DeleteMedicationEvent extends AsthmaEvent {
  final int id;

  DeleteMedicationEvent({required this.id});
}

class DeleteSymptomEvent extends AsthmaEvent {
  final int id;

  DeleteSymptomEvent({required this.id});
}

class ChooseSymptomEvent extends AsthmaEvent {
  final String selectedSymptom;

  ChooseSymptomEvent(this.selectedSymptom);
}

class ChooseLevelEvent extends AsthmaEvent {
  final String selectedLevel;

  ChooseLevelEvent(this.selectedLevel);
}
