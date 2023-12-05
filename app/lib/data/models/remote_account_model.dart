import './/domain/entities/entities.dart';

class RemoteAccountModel {
  final bool isAdmin;
  final bool isSalesman;
  final bool isCustomer;
  final String salesman;
  final String customer;
  final String logged;
  final String token;

  RemoteAccountModel({
    required this.isAdmin,
    required this.isSalesman,
    required this.isCustomer,
    required this.salesman,
    required this.customer,
    required this.logged,
    required this.token,
  });

  AccountEntity toEntity() => AccountEntity(
        customer: customer,
        isAdmin: isAdmin,
        isSalesman: isSalesman,
        isCustomer: isCustomer,
        logged: logged,
        salesman: salesman,
        token: token,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isAdmin': isAdmin,
      'isSalesman': isSalesman,
      'salesman': salesman,
      'customer': customer,
      'logged': logged,
      'token': token,
    };
  }

  factory RemoteAccountModel.fromMap(Map<String, dynamic> map) {
    return RemoteAccountModel(
      isAdmin: map['isAdmin'] as bool,
      isSalesman: map['isSalesman'] as bool,
      isCustomer: map['isCustomer'] as bool,
      salesman: map['salesman'] as String,
      customer: map['customer'] as String,
      logged: map['logged'] as String,
      token: map['token'] as String,
    );
  }
}
