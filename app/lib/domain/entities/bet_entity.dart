import './/domain/entities/entities.dart';

class BetEntity {
  final List<String> guesses;
  final List<ProductEntity> products;

  BetEntity({
    this.guesses = const [],
    this.products = const [],
  });

  BetEntity copyWith({
    List<String>? guesses,
    List<ProductEntity>? products,
  }) {
    return BetEntity(
      guesses: guesses ?? this.guesses,
      products: products ?? this.products,
    );
  }
}
