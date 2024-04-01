// ignore_for_file: prefer_const_constructors

import 'package:gearhaven/app/components/customs/custom_button.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:gearhaven/app/utils/assets.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:gearhaven/app/views/views/edit_profile_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/views/views/order_status_view.dart';
import 'package:gearhaven/app/views/views/payment_confirmation_view.dart';

import 'package:get/get.dart';
import 'package:get_ip_address/get_ip_address.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProfilePageController());
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF14213D),
      //   foregroundColor: Colors.white,
      //   title: const Text('ProfilePageView'),
      //   centerTitle: true,
      // ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 25),
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  child: const Icon(
                    CupertinoIcons.back,
                    size: 30,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border:
                      Border.all(color: CustomColors.primaryColor, width: 2),
                ),
                child: Obx(
                  () => controller.currentUser.value.profileImage != null
                      ? CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            getUserImageUrl(
                              controller.currentUser.value.profileImage,
                            ),
                          ),
                        )
                      : controller.selectedImageBytes.value != null
                          ? CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(
                                getUserImageUrl(
                                  controller.currentUser.value.profileImage,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 70,
                              backgroundImage: AssetImage(
                                Assets.profileImagePlaceholder,
                              ),
                            ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => Text(
                  controller.currentUser.value.userName ?? 'No Username',
                  style: TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          color: CustomColors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => EditProfilePageView());
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.edit_note_outlined,
                              size: 25,
                              color: CustomColors.primaryColor,
                            ),
                            Text(
                              "Edit",
                              style: TextStyle(
                                color: CustomColors.primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  //End of text rows with edit button
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: CustomColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                color: CustomColors.backgroundColor,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              controller.emailController.text,
                              style: TextStyle(
                                color: CustomColors.backgroundColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: CustomColors.backgroundColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Contact",
                              style: TextStyle(
                                color: CustomColors.backgroundColor,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              controller.contactController.text,
                              style: TextStyle(
                                color: CustomColors.backgroundColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: CustomColors.backgroundColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Location",
                              style: TextStyle(
                                color: CustomColors.backgroundColor,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              controller.locationController.text,
                              style: TextStyle(
                                color: CustomColors.backgroundColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Utilities",
                        style: TextStyle(
                          color: CustomColors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  //End of text rows with edit button
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: CustomColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.paste_outlined,
                                  color: CustomColors.backgroundColor,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Listed Products",
                                  style: TextStyle(
                                    color: CustomColors.backgroundColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const PaymentConfirmationView());
                              },
                              child: Icon(
                                CupertinoIcons.forward,
                                color: CustomColors.backgroundColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: CustomColors.backgroundColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.shop_outlined,
                                  color: CustomColors.backgroundColor,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Items Sold",
                                  style: TextStyle(
                                    color: CustomColors.backgroundColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const OrderStatusView());
                              },
                              child: Icon(
                                CupertinoIcons.forward,
                                color: CustomColors.backgroundColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: CustomColors.backgroundColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.history,
                                  color: CustomColors.backgroundColor,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Purchase History",
                                  style: TextStyle(
                                    color: CustomColors.backgroundColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                CupertinoIcons.forward,
                                color: CustomColors.backgroundColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: CustomColors.backgroundColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.privacy_tip_outlined,
                                  color: CustomColors.backgroundColor,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                    color: CustomColors.backgroundColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                var ip = IpAddress(type: RequestType.text);
                                Future<String> getIp() async {
                                  dynamic data = await ip.getIpAddress();
                                  return data;
                                }

                                String ipString = await getIp();
                                debugPrint(ipString);
                              },
                              child: Icon(
                                CupertinoIcons.forward,
                                color: CustomColors.backgroundColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: CustomColors.backgroundColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 15,
                                    ),
                                    width: 450,
                                    height: 100,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Are you sure you want to log out?",
                                          style: TextStyle(
                                            fontSize: 19,
                                            color: CustomColors.primaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CustomButton(
                                              width: 50,
                                              height: 50,
                                              labelStyle: TextStyle(
                                                fontSize: 19,
                                                color: Colors.white,
                                              ),
                                              label: 'Yes',
                                              onPressed: () {
                                                LocalStorage.removeAll();
                                                Get.toNamed(Routes.LOGIN);
                                              },
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            CustomButton(
                                              width: 50,
                                              height: 50,
                                              labelStyle: TextStyle(
                                                fontSize: 19,
                                                color: Colors.white,
                                              ),
                                              label: 'No',
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.logout_outlined,
                                    color: CustomColors.backgroundColor,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Log Out",
                                    style: TextStyle(
                                      color: CustomColors.backgroundColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  CupertinoIcons.forward,
                                  color: CustomColors.backgroundColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
