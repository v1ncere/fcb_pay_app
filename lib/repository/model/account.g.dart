// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      account: json['account'] as int,
      balance: json['balance'] as int,
      walletBalance: json['wallet_balance'] as int,
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'account': instance.account,
      'balance': instance.balance,
      'wallet_balance': instance.walletBalance,
    };
