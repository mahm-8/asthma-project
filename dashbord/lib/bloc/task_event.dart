part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

final class AddTaskEvent extends TaskEvent {
  final String task;

  AddTaskEvent({required this.task});
}

final class DeleteTaskEvent extends TaskEvent {
  final int idTask;

  DeleteTaskEvent({required this.idTask});
}

final class getTaskEvent extends TaskEvent {
  getTaskEvent();
}
