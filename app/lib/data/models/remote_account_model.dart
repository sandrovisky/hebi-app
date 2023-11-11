import './/domain/entities/entities.dart';

class RemoteAccountModel {
  final bool isAdmin;
  final bool isSalesman;
  final String salesman;
  final String customer;
  final String reference;
  final String token;

  RemoteAccountModel({
    required this.isAdmin,
    required this.isSalesman,
    required this.salesman,
    required this.customer,
    required this.reference,
    required this.token,
  });

  AccountEntity toEntity() => AccountEntity(
        customer: customer,
        isAdmin: isAdmin,
        isSalesman: isSalesman,
        reference: reference,
        salesman: salesman,
        token: token,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isAdmin': isAdmin,
      'isSalesman': isSalesman,
      'salesman': salesman,
      'customer': customer,
      'reference': reference,
      'token': token,
    };
  }

  factory RemoteAccountModel.fromMap(Map<String, dynamic> map) {
    return RemoteAccountModel(
      isAdmin: map['isAdmin'] as bool,
      isSalesman: map['isSalesman'] as bool,
      salesman: map['salesman'] as String,
      customer: map['customer'] as String,
      reference: map['reference'] as String,
      token: map['token'] as String,
    );
  }
}
