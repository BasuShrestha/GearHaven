import 'package:gearhaven/app/models/product.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Icon? icon;
  final VoidCallback? onIconPress;
  final bool? hideIcon;
  final bool? showDeleteIcon;
  final VoidCallback? onDeleteIconPress;
  const ProductCard({
    super.key,
    required this.product,
    this.hideIcon = false,
    this.icon,
    this.onIconPress,
    this.showDeleteIcon = false,
    this.onDeleteIconPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Hero(
                tag: 'product+${product.productId}',
                child: Image.network(
                  getProductImageUrl(
                    product.productImage,
                  ),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName?.toUpperCase() ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          product.productconditionName.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs${product.productPrice ?? ''}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        !hideIcon!
                            ? InkWell(
                                onTap: onIconPress,
                                child: Row(
                                  children: [
                                    icon ?? const Icon(Icons.shopping_cart),
                                    showDeleteIcon!
                                        ? GestureDetector(
                                            onTap: onDeleteIconPress,
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          )
                                        : const SizedBox(
                                            width: 0,
                                          ),
                                  ],
                                ),
                              )
                            : const Text(''),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
