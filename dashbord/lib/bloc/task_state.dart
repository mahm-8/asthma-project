part of 'task_bloc.dart';

abstract class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoadingState extends TaskState {}

final class TaskUpdateState extends TaskState {}

final class GetTaskState extends TaskState {
  final List<TaskModel> tasks;
  GetTaskState({required this.tasks});
}

final class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState({required this.message});
}
