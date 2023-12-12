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
  List<LocationModel>? hospitalData;
  List<MedicationModel>? medicationData;
  List<SymptomsModel>? symptomsData;

  AsthmaBloc() : super(AsthmaInitial()) {
    on<getHospitalDataEvent>(getData);
    on<GetMedicationDataEvent>(getMedicationData);
    on<GetSymptomDataEvent>(getSymptomsData);
    on<AddMedicationEvent>(addMedicationMethod);
    on<AddSymptomEvent>(addSymptomMethod);
    on<DeleteMedicationEvent>(deleteMedicationMethod);
    on<DeleteSymptomEvent>(deleteSymtomMethod);
    add(GetMedicationDataEvent());
    add(GetSymptomDataEvent());
  }
// xbox-w@live.com
//12345Aa!
  Future<void> getData(
      getHospitalDataEvent event, Emitter<AsthmaState> emit) async {
    try {
      emit(LoadingState());
      hospitalData = await SupabaseServer().getHospitalData();
      await Future.delayed(const Duration(seconds: 1));

      emit(SuccessHospitalState(hospitalData));
    } catch (error) {
      print(error);
      emit(ErrorState());
    }
  }

  FutureOr<void> getMedicationData(
      GetMedicationDataEvent event, Emitter<AsthmaState> emit) async {
    try {
      emit(LoadingState());
      medicationData = await SupabaseServer().getMedication();
      await Future.delayed(const Duration(seconds: 1));
      emit(SuccessGetMedicationState(medications: medicationData!));
    } catch (error) {
      emit(ErrorState());
    }
  }

  FutureOr<void> getSymptomsData(
      GetSymptomDataEvent event, Emitter<AsthmaState> emit) async {
    try {
      emit(LoadingState());
      symptomsData = await SupabaseServer().getSymptoms();
      await Future.delayed(const Duration(seconds: 1));
      emit(SuccessGetSymptomState(symptoms: symptomsData!));
    } catch (error) {
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
        emit(SuccessAddSymptomState());
        add(GetSymptomDataEvent());
        emit(LoadingState());
        emit(SucsessMessageState(message: 'symptoms added'));
      } else {
        emit(ADDErrorState(message: 'Please fill all the fields'));
      }
    } catch (e) {
      emit(ErrorGetState(message: e.toString()));
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
        emit(SuccessAddMedicationState());
        add(GetMedicationDataEvent());
        emit(LoadingState());
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
      await SupabaseServer().deleteMedication(id: event.id);
      await Future.delayed(const Duration(seconds: 1));
      allMedication.remove(event.id);
      add(GetMedicationDataEvent());
      emit(LoadingState());
    } catch (error) {
      emit(ErrorState());
    }
  }

  FutureOr<void> deleteSymtomMethod(
      DeleteSymptomEvent event, Emitter<AsthmaState> emit) async {
    try {
      await SupabaseServer().deleteSymptom(id: event.id);
      await Future.delayed(const Duration(seconds: 1));
      allSymptoms.remove(event.id);
      add(GetSymptomDataEvent());
      emit(LoadingState());
    } catch (error) {
      emit(ErrorState());
    }
  }
}
