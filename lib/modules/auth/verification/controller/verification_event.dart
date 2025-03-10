abstract class VerificationEvent {}

class VerificationRecoveryCodeEvent extends VerificationEvent {
  final String code;

  VerificationRecoveryCodeEvent({
    required this.code,
  });
}

class VerificationButtomEvent extends VerificationEvent {
  final bool isEnable;

  VerificationButtomEvent(this.isEnable);
}
