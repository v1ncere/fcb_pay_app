import 'package:fcb_pay_app/repository/database_service.dart';
import 'package:fcb_pay_app/repository/model/account.dart';

class AccountRepository extends AccountRepo{
  DatabaseService service = DatabaseService();
  
  @override
  Future<List<AccountModel>> getData() {
    return service.getData();
  }

}

abstract class AccountRepo {
  Future<List<AccountModel>> getData();
}