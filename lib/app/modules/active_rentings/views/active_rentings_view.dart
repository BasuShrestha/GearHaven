import 'package:flutter/material.dart';
import 'package:gearhaven/app/components/active_renting_card.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:gearhaven/app/utils/local_storage.dart';

import 'package:get/get.dart';

import '../controllers/active_rentings_controller.dart';

class ActiveRentingsView extends GetView<ActiveRentingsController> {
  const ActiveRentingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ActiveRentingsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Active Rentings',
          style: TextStyle(
            color: CustomColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: CustomColors.backgroundColor,
        centerTitle: true,
      ),
      body: GetBuilder<ActiveRentingsController>(
        builder: (controller) => Container(
          height: Get.height,
          color: CustomColors.backgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: controller.activeRentings.isEmpty
              ? const Center(
                  child: Text(
                    'No active rentings...',
                    style: TextStyle(
                      fontSize: 22,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.activeRentings.length,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      RentingCard(
                        renting: controller.activeRentings[index],
                        index: index,
                        rentingStatuses: controller.rentingStatuses,
                        onStatusChanged: (newStatus) {
                          debugPrint(
                              "Device FCM Token: ${LocalStorage.getFcmToken()}");
                          debugPrint(
                              "Buyer FCM Token: ${controller.activeRentings[index].fcmToken}");
                          debugPrint(
                              controller.activeRentings[index].productName);
                          controller.updateRentingStatus(
                            //controller.activeRentings[index].orderId ?? 0,
                            rentingId:
                                controller.activeRentings[index].rentingId ?? 0,
                            productId:
                                controller.activeRentings[index].productId ?? 0,
                            productName:
                                controller.activeRentings[index].productName,
                            newStatus: newStatus,
                            // controller.activeRentings[index].fcmToken ?? 'No Fcm',
                          );
                        },
                      ),
                      Positioned(
                        right: 10,
                        top: 50,
                        child: Text(
                          'Total: ${controller.activeRentings[index].amountPaid}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
