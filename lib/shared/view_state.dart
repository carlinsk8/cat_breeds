import '../core/error/failure.dart';

abstract class ViewState{
}

class Idle extends ViewState {}

class Loading extends ViewState {}

class Loaded<T> extends ViewState {
  final T? value;

  Loaded({this.value});

}

class Error extends ViewState {
  final Failure failure;

  Error({required this.failure});

}