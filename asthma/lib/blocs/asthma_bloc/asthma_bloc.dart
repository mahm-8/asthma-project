import 'dart:async';
import 'package:asthma/Models/location_model.dart';
import 'package:asthma/Models/medication_model.dart';
import 'package:asthma/Models/symptoms_model.dart';
import 'package:asthma/Screens/HomeScreen/widgets/location_functions.dart';
import 'package:asthma/Services/supabase.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
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
    on<ChooseSymptomEvent>(changeSymptom);
    on<ChooseLevelEvent>(changeLevel);
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
      print('1');
      if (hospitalData != null) {
        print('2');
        for (var location in hospitalData!) {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          currentLocation = position;
          print(currentLocation);

          double distance = Geolocator.distanceBetween(
            currentLocation!.latitude,
            currentLocation!.longitude,
            location.latitude!,
            location.longitude!,
          );

          print('4');
          location.distance = distance;
          nearestLocations.add(location);
        }
        nearestLocations.sort((a, b) => a.distance!.compareTo(b.distance!));
        nearestLocations = nearestLocations.take(5).toList();
        emit(SuccessHospitalState(nearestLocations));
      }
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
      emit(LoadingState());
      if (event.symptomName.isNotEmpty && event.symtomDetails.isNotEmpty) {
        SupabaseServer().addSymptom({
          "symptom_name": event.symptomName,
          "description": event.symtomDetails,
          "intensity": event.symptomIntensity,
        });
        emit(SuccessAddSymptomState());
        add(GetSymptomDataEvent());

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
      emit(LoadingState());
      if (event.medicationName.isNotEmpty &&
          event.days != null &&
          event.date.isNotEmpty) {
        SupabaseServer().addMedication({
          "name": event.medicationName,
          "days": event.days,
          "date": event.date,
        });
        
        emit(SuccessAddMedicationState(message: 'Medication Added'));
        add(GetMedicationDataEvent());
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

  FutureOr<void> changeSymptom(
      ChooseSymptomEvent event, Emitter<AsthmaState> emit) {
    emit(ChangeSymptomState(event.selectedSymptom));
  }

  FutureOr<void> changeLevel(
      ChooseLevelEvent event, Emitter<AsthmaState> emit) {
    emit(ChangeLevelState(event.selectedLevel));
  }
}
