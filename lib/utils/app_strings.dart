class AppString {
  static const String appName = 'FCBPay';
  // create pin bloc strings
  static const String setupPinTitle = "Setup PIN";
  static const String useSixDigitsPin = "Use a 6-digit PIN";
  static const String pinCreationSuccess = "Your PIN code has been successfully created";
  static const String pinCreationFailure = "The entered PIN codes do not match";
  // authentication pin bloc strings
  static const String setupPin = "Setup PIN";
  static const String createPin = "Create PIN";
  static const String authenticationSuccess = "Login Success";
  static const String authenticationFailure = "Login Failed";
  // biometric auth cubit strings
  static const String localizedReason = 'Scan your fingerprint to authenticate';
  static const String authSuccess = 'Welcome! You\'re securely authenticated.';
  static const String authFailure = 'Oops! Authentication failed. Please try again';
  static const String biometricDisabled = 'Biometric authentication is currently disabled. Enable it in settings for added security.';
  static const String biometricUnsupported = 'Sorry, your device doesn\'t support biometric authentication.';
}