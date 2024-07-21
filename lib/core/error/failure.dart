

abstract class Failure {
  final String? message;

  const Failure({this.message});

}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message});
}

