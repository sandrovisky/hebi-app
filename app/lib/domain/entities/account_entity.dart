class AccountEntity {
  final bool isAdmin;
  final bool isSalesman;
  final String salesman;
  final String customer;
  final String logged;
  final String token;

  AccountEntity({
    required this.isAdmin,
    required this.isSalesman,
    required this.salesman,
    required this.customer,
    required this.logged,
    required this.token,
  });

  AccountEntity copyWith({
    bool? isAdmin,
    bool? isSalesman,
    String? salesman,
    String? customer,
    String? logged,
    String? token,
  }) {
    return AccountEntity(
      isAdmin: isAdmin ?? this.isAdmin,
      isSalesman: isSalesman ?? this.isSalesman,
      salesman: salesman ?? this.salesman,
      customer: customer ?? this.customer,
      logged: logged ?? this.logged,
      token: token ?? this.token,
    );
  }

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

  factory AccountEntity.fromMap(Map<String, dynamic> map) {
    return AccountEntity(
      isAdmin: map['isAdmin'] as bool,
      isSalesman: map['isSalesman'] as bool,
      salesman: map['salesman'] as String,
      customer: map['customer'] as String,
      logged: map['logged'] as String,
      token: map['token'] as String,
    );
  }
}
