class AppString {
  static const String appName = 'FCBPay';
  // local authentication
  static const String setupPin = "Setup PIN";
  static const String createPin = "Create PIN";
  static const String updatePin = "Update PIN";
  static const String currentPin = "Current PIN";
  static const String useSixDigitsPin = "Use a 6-digit PIN";
  static const String enterYourPIN = "Please enter your PIN";
  static const String confirmPin = "Re-enter your PIN";
  static const String confirmPinSuccess = "Your PIN code has been successfully created";
  static const String confirmPinFailure = "The entered PIN codes do not match";
  static const String authenticationSuccess = "Login Success";
  static const String authenticationFailure = "Login Failed";
  static const String currentPinAccepted = "PIN Accepted";
  static const String currentPinRejected = "PIN Failed";
  static const String updatePinSuccess = "Your PIN code has been successfully changed";
  // biometric authentication
  static const String localizedReason = 'Scan your fingerprint to authenticate';
  static const String authSuccess = 'Welcome! You\'re securely authenticated.';
  static const String authFailure = 'Oops! Authentication failed. Please try again';
  static const String biometricDisabled = 'Biometric authentication is currently disabled. Enable it in settings for added security.';
  static const String biometricUnsupported = 'Sorry, your device doesn\'t support biometric authentication.';
}