abstract class Failure {
  final String message;

  Failure(this.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class RegisterFailure extends Failure {
  RegisterFailure(super.message);
}

class BusinessRegisterFailure extends Failure {
  BusinessRegisterFailure(super.message);
}

class LoanFailure extends Failure {
  LoanFailure(super.message);
}