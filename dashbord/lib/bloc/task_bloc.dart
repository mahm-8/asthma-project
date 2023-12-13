import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dashboard/model/task_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<TaskEvent>((event, emit) {});
    on<AddTaskEvent>(addTask);
    on<getTaskEvent>(getTask);
  }

  FutureOr<void> addTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      await Supabase.instance.client
          .from('tasks')
          .insert({'task': event.task, "id_user": getCurrentUserId});
      emit(TaskUpdateState());
    } catch (e) {
      print(e);
    }
  }

  get getCurrentUserId => Supabase.instance.client.auth.currentUser!.id;
  FutureOr<void> getTask(getTaskEvent event, Emitter<TaskState> emit) async {
    try {
      final List allTasks = await Supabase.instance.client
          .from("tasks")
          .select()
          .eq("id_user", getCurrentUserId);
      print(getCurrentUserId);
      final List<TaskModel> tasks =
          allTasks.map((task) => TaskModel.fromJson(task)).toList();
      print(tasks);
      emit(getTaskState(tasks: tasks));
    } catch (e) {
      print(e);
    }
  }
}
