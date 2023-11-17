class AccountModel {
  const AccountModel({
    this.account = '',
    this.type = ''
  });
  final String account;
  final String type;

  AccountModel copyWith({
    String? account,
    String? type
  }) {
    return AccountModel(
      account: account ?? this.account,
      type: type ?? this.type
    );
  }

  static const empty = AccountModel(account: '', type: '');
}