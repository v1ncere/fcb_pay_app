import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AccountModel {
  const AccountModel({
    required this.account,
    required this.balance,
    required this.walletBalance,
  });

  final int account;
  final int balance;
  final int walletBalance;

  factory AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}
