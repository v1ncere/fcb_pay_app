class AssetString {
  static const String coverBG  = 'assets/image/bg.png';
  static const String fcbLogo  = 'assets/image/fcb-logo.png';
  static const String profileBG  = 'assets/image/profile-bg.png';
  static const String splashLogo  = 'assets/image/splash.png';

  static const String otpSVG  = 'assets/svg/otp.svg';
  static const String loginLogo  = 'assets/svg/login.svg';
  static const String creditCardPayment  = 'assets/svg/credit_card_payment.svg';
  static const String creditCardPayment2  = 'assets/svg/credit_card_payments.svg';
  static const String mobilePay  = 'assets/svg/mobile_pay.svg';
  static const String onlineBanking  = 'assets/svg/online_banking.svg';
  static const String onlinePayments  = 'assets/svg/online_payments.svg';
  static const String onlineTransactions  = 'assets/svg/online_transactions.svg';
  static const String payments  = 'assets/svg/payments.svg';
  static const String profileData  = 'assets/svg/profile_data.svg';
  static const String transferMoney  = 'assets/svg/transfer_money.svg';
}

String accountTypeString(String type) {
  final data = type.toLowerCase();
  switch (data) {
    case 'wallet':
      return 'WALLET';
    case 'sa':
      return 'SAVINGS';
    case 'cc':
      return 'CREDIT';
    default:
      return '';
  }
}