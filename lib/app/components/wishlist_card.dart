import 'package:gearhaven/app/models/wishlist.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:flutter/material.dart';

class WishlistCard extends StatelessWidget {
  final Wishlist product;
  // final Icon? icon;
  // final VoidCallback? onIconPress;
  final bool? hideIcon;
  final bool? hideDeleteIcon;
  final VoidCallback? onDeleteIconPress;
  const WishlistCard({
    super.key,
    required this.product,
    this.hideIcon = false,
    // this.icon,
    // this.onIconPress,
    this.hideDeleteIcon = false,
    this.onDeleteIconPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
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
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Hero(
                    tag: 'product+${product.productId}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        getProductImageUrl(
                          product.productImage,
                        ),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: hideIcon! ? 1 : 2,
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
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Category: ${product.categoryName}",
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Size: ${product.productsizeName}",
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Available after: ${product.toDate.toString().split(' ')[0]}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          hideDeleteIcon!
              ? SizedBox.shrink()
              : Positioned(
                  bottom: 30,
                  right: 10,
                  child: InkWell(
                    onTap: onDeleteIconPress,
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
