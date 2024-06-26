enum Status { initial, loading, success, authenticate, error }

extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isAuthenticate => this == Status.authenticate;
  bool get isError => this == Status.error;
}

enum AccountType { unknown, savings, credit, loans }

extension AccountTypeX on AccountType {
  bool get isUnknown => this == AccountType.unknown;
  bool get isSavings => this == AccountType.savings;
  bool get isCredit => this == AccountType.credit;
  bool get isLoans => this == AccountType.loans;
}