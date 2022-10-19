import 'package:fcb_pay_app/repository/model/account.dart';

abstract class BaseAccountRepository {
  Stream<List<AccountModel>> getAllAccount();
}