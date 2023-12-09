import 'dart:async';
import 'package:asthma/Models/location_model.dart';
import 'package:asthma/Models/medication_model.dart';
import 'package:asthma/Models/symptoms_model.dart';
import 'package:asthma/Services/supabase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'asthma_event.dart';
part 'asthma_state.dart';

class AsthmaBloc extends Bloc<AsthmaEvent, AsthmaState> {
  LocationModel? hospitalData;
  // MedicationModel? medicationData;
  // SymptomsModel? symptomsData;

  AsthmaBloc() : super(AsthmaInitial()) {
    on<getHospitalDataEvent>(getData);
    on<GetMedicationDataEvent>(getMedicationData);
    on<GetSymptomDataEvent>(getSymptomsData);
    on<AddMedicationEvent>(addMedicationMethod);

    on<AddSymptomEvent>(addSymptomMethod);
    on<DeleteMedicationEvent>(deleteMedicationMethod);
    on<DeleteSymptomEvent>(deleteSymtomMethod);
  }

  Future<void> getData(
      getHospitalDataEvent event, Emitter<AsthmaState> emit) async {
    try {
      emit(LoadingState());
      hospitalData = await SupabaseServer().getHospitalData();
      print("i am here 1");
      await Future.delayed(const Duration(seconds: 1));
      emit(LoadingState());
      emit(SuccessHospitalState());
    } catch (error) {
      print(error);
      emit(ErrorState());
    }
  }

  FutureOr<void> getMedicationData(
      GetMedicationDataEvent event, Emitter<AsthmaState> emit) async {
    try {
      emit(LoadingState());
      List<MedicationModel> medicationData =
          await SupabaseServer().getMedication();
      await Future.delayed(const Duration(seconds: 1));
      emit(LoadingState());
      emit(SuccessGetMedicationState(medications: medicationData));
    } catch (error) {
      print(error);
      emit(ErrorState());
    }
  }

  FutureOr<void> getSymptomsData(
      GetSymptomDataEvent event, Emitter<AsthmaState> emit) async {
    try {
      emit(LoadingState());
      List<SymptomsModel> symptomsData = await SupabaseServer().getSymptoms();
      await Future.delayed(const Duration(seconds: 1));
      emit(LoadingState());
      emit(SuccessGetSymptomState(symptoms: symptomsData));
    } catch (error) {
      print(error);
      emit(ErrorState());
    }
  }

  FutureOr<void> addSymptomMethod(
      AddSymptomEvent event, Emitter<AsthmaState> emit) {
    try {
      if (event.symptomName.isNotEmpty && event.symtomDetails.isNotEmpty) {
        SupabaseServer().addSymptom({
          "symptom_name": event.symptomName,
          "description": event.symtomDetails,
          "intensity": event.symptomIntensity,
        });
        allSymptoms.add(SymptomsModel(
            symptomName: event.symptomName,
            symptomDetails: event.symtomDetails,
            symptomIntensity: event.symptomIntensity));
        emit(SuccessAddSymptomState());
        emit(SucsessMessageState(message: 'symptoms added'));
      } else {
        emit(ADDErrorState(message: 'Please fill all the fields'));
      }
    } catch (e) {
      emit(ErrorGetState(message: e.toString()));
      // emit(ErrorState(e.toString()));
    }
  }

  FutureOr<void> addMedicationMethod(
      AddMedicationEvent event, Emitter<AsthmaState> emit) {
    try {
      if (event.medicationName.isNotEmpty &&
          event.days != null &&
          event.date.isNotEmpty) {
        SupabaseServer().addMedication({
          "name": event.medicationName,
          "days": event.days,
          "date": event.date,
        });
        allMedication.add(MedicationModel(
            medicationName: event.medicationName,
            days: event.days,
            date: event.date));
        emit(SuccessAddMedicationState());
        emit(SucsessMessageState(message: 'Medication Added'));
      } else {
        emit(ADDErrorState(message: 'Please fill all the fields'));
      }
    } catch (e) {
      emit(ErrorGetState(message: e.toString()));
    }
  }

  FutureOr<void> deleteMedicationMethod(
      DeleteMedicationEvent event, Emitter<AsthmaState> emit) async {
    try {
      await SupabaseServer().deleteMedication(id: event.id!);
      await Future.delayed(const Duration(seconds: 2));
      allMedication.remove(event.id);
      emit(LoadingState());
      emit(SuccessDeleteState());
    } catch (error) {
      print(error);
      emit(ErrorState());
    }
  }

  FutureOr<void> deleteSymtomMethod(
      DeleteSymptomEvent event, Emitter<AsthmaState> emit) async {
    try {
      await SupabaseServer().deleteSymptom(id: event.id!);
      await Future.delayed(const Duration(seconds: 1));
      emit(LoadingState());
      emit(SuccessDeleteState());
    } catch (error) {
      print(error);
      emit(ErrorState());
    }
  }
}
