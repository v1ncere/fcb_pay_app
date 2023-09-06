class PaymentFailure implements Exception {
  const PaymentFailure([
    this.message = 'An unknown exception occurred.'
  ]);
  factory PaymentFailure.fromCode(String code) {
    switch (code) {
      case 'incomplete-additional-form':
        return const PaymentFailure(
          'Incomplete Form: Please review the form and fill in all additional fields.'
        );
      case 'incomplete-form':
        return const PaymentFailure(
          'Incomplete Form: Please review the form and fill in all required fields.'
        );
      default:
        return const PaymentFailure();
    }
  }
  final String message;
}