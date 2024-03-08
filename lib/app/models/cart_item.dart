import 'package:gearhaven/app/models/product.dart';

class CartItem {
  final Product product;
  bool isSelected;
  int quantity;

  CartItem({
    required this.product,
    this.isSelected = false,
    this.quantity = 1,
  });
}
