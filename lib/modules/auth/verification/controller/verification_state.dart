class VerificationState {}

class VerificationInitialState extends VerificationState {}

class VerificationLoadingState extends VerificationState {}

class VerificationSuccessState extends VerificationState {}

class VerificationErrorState extends VerificationState {
  final String message;

  VerificationErrorState(this.message);
}

class VerificationButtomState extends VerificationState {
  final bool isEnable;

  VerificationButtomState(this.isEnable);
}
