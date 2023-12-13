part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoadingState extends TaskState {}

final class TaskUpdateState extends TaskState {}

final class getTaskState extends TaskState {
  final List<TaskModel> tasks;
  getTaskState({required this.tasks});
}

final class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState({required this.message});
}
