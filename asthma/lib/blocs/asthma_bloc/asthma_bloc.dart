import 'dart:async';

import 'package:asthma/Models/location_model.dart';
import 'package:asthma/Services/supabase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'asthma_event.dart';
part 'asthma_state.dart';

class AsthmaBloc extends Bloc<AsthmaEvent, AsthmaState> {
   LocationModel? hospitalData;
  AsthmaBloc() : super(AsthmaInitial()) {
   
    on<AsthmaEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<getHospitalDataEvent>(getData);
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
}
