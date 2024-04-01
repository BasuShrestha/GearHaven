import 'package:gearhaven/app/models/renting.dart';
import 'package:gearhaven/app/modules/cart/controllers/cart_controller.dart';
import 'package:gearhaven/app/utils/assets.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentingCard extends StatelessWidget {
  final Renting renting;
  final int index;
  final List<String> rentingStatuses;
  final Function(String) onStatusChanged;
  const RentingCard({
    super.key,
    required this.renting,
    required this.index,
    required this.rentingStatuses,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    String? currentStatus = renting.rentingStatus ?? rentingStatuses.first;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 20),
      height: 145,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: renting.productImage == null
                ? Image.asset(
                    Assets.cartItemImagePlaceholder,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  )
                : Container(
                    padding: EdgeInsets.all(5),
                    child: Image.network(
                      getProductImageUrl(
                        renting.productImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    renting.productName ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Buyer: ${renting.userName}',
                    style: const TextStyle(fontSize: 11),
                  ),
                  Text(
                    'Contact: ${renting.userContact}',
                    style: const TextStyle(fontSize: 11),
                  ),
                  Text(
                    'Delivery location: ${renting.userLocation}',
                    style: const TextStyle(fontSize: 11),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Renting Status"),
                      DropdownButton<String>(
                        value: currentStatus,
                        icon: const Icon(Icons.arrow_downward),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            onStatusChanged(newValue);
                          }
                        },
                        items: rentingStatuses
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
