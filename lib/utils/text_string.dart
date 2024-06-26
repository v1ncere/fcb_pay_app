class TextString {
  static const String appName = 'FCBPay';
  // local authentication
  static const String setupPin = 'Setup PIN';
  static const String createPin = 'Create PIN';
  static const String updatePin = 'Update PIN';
  static const String currentPin = 'Current PIN';
  static const String useSixDigitsPin = 'Use a 6-digit PIN';
  static const String enterYourPIN = 'Please enter your PIN';
  static const String confirmPin = 'Re-enter your PIN';
  static const String confirmPinSuccess = 'Your PIN code has been successfully created';
  static const String confirmPinFailure = 'The entered PIN codes do not match';
  static const String authenticationSuccess = 'Login Success';
  static const String authenticationFailure = 'Login Failed';
  static const String currentPinAccepted = 'PIN Accepted';
  static const String currentPinRejected = 'PIN Failed';
  static const String updatePinSuccess = 'Your PIN code has been successfully changed';
  // biometric authentication
  static const String localizedReason = 'Scan your fingerprint to authenticate';
  static const String authSuccess = 'Welcome! You\'re securely authenticated.';
  static const String authFailure = 'Oops! Authentication failed. Please try again';
  static const String biometricEnabled = 'Use fingerprint for authentication';
  static const String biometricDisabled = 'Biometric authentication is currently disabled. Enable it in settings for added security.';
  static const String biometricUnsupported = 'Sorry, your device doesn\'t support biometric authentication.';
  // network connectivity
  static const String internetError = 'No internet connection. Please check your network settings.';
  // form error
  static const String incompleteForm = 'Incomplete Form: Please review the form and make sure all required fields are filled in correctly.';
  static const String formError = 'Please complete all required fields before submitting your form. Thank you!';
  static const String invalidDate = 'Invalid date format. Please enter a valid date in the format: dd/MM/yyyy.';
  static const String registrationNote = 'Please verify your data for accuracy and completeness before proceeding with the registration.';
  // firebase 
  static const String verifyEmail = "Please verify your email address to continue. We've sent a verification link to your email.";
  static const String noEmail = 'Phone number not registered. Please sign up first.';
  static const String verifyRequest = "Registration account successful! We've sent a verification link to your email.";
  // FCB SLOGAN
  static const String slogan = 'Where Quality Service is a Commitment.';
  // OTP
  static const String otpSuccess = 'OTP verified. Access granted.';
  static const String otpExpired = "The authentication code has expired. Click 'Resend Code' to receive a new code.";
  // MULTIFACTOR AUTH
  static const String mfaTitle = 'Multi-Factor Authentication';
  // ACCOUNT
  static const String accountAlreadyLinked = 'Account has already been link to a user.';
  static const String accountNotExist = 'The account you entered does not exist.';
  static const String accountEmpty = 'You need to register an account to proceed with this transaction.';
  static const String accountAddSuccess = 'Your request to add the account has been successful!';
  static const String accountAddFailure = 'Your request to add the account has failed.';
  // GENERAL ERROR
  static const String error = 'Oops! Something went wrong.';
  static const String empty = 'Empty';
  // IMAGE NOTE
  static const String imageNote = 'Note: Please hold your credit card near your chest and take a picture of yourself with it, ensuring the card is readable by the app. This will verify your existing account.';
  // transactions
  static const String transactionNote = 'Please verify your data for accuracy and completeness before proceeding with the transaction.';
  static const String transactionDisabled = 'Please contact support to enable this transaction.';
  static const String transactionSuccess = 'Transaction Successful!';
}