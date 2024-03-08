// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:typed_data';

import 'package:gearhaven/app/components/customs/custom_button.dart';
import 'package:gearhaven/app/components/customs/edit_profile_form.dart';
import 'package:gearhaven/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:gearhaven/app/utils/assets.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePageView extends GetView {
  const EditProfilePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE5E5E5),
        body: GetBuilder<ProfilePageController>(
          builder: (controller) => Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
            width: Get.width,
            child: SingleChildScrollView(
              child: Form(
                key: controller.editProfileFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: CustomColors.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: CustomColors.primaryColor, width: 2),
                            ),
                            child: controller.selectedImageBytes.value != null
                                ? CircleAvatar(
                                    radius: 100,
                                    backgroundImage: MemoryImage(
                                      controller.selectedImageBytes.value!,
                                    ),
                                  )
                                : controller.currentUser.value.profileImage !=
                                        null
                                    ? CircleAvatar(
                                        radius: 100,
                                        backgroundImage: NetworkImage(
                                          getUserImageUrl(
                                            controller
                                                .currentUser.value.profileImage,
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 100,
                                        backgroundImage: AssetImage(
                                          Assets.profileImagePlaceholder,
                                        ),
                                      ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () async {
                              controller.profileImage = await controller.picker
                                  .pickImage(source: ImageSource.gallery);
                              if (controller.profileImage != null) {
                                controller.selectedImagePath.value =
                                    controller.profileImage!.name;
                                Uint8List imageBytes = await controller
                                    .profileImage!
                                    .readAsBytes();
                                controller.selectedImageBytes.value =
                                    imageBytes;
                              }
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: CustomColors.primaryColor,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: CustomColors.backgroundColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EditProfileForm(
                          controller: controller.firstNameController,
                          label: "First Name",
                          width: 170,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        EditProfileForm(
                          controller: controller.lastNameController,
                          label: "Last Name",
                          width: 170,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    EditProfileForm(
                      controller: controller.emailController,
                      label: "Email",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    EditProfileForm(
                      controller: controller.contactController,
                      label: "Contact",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    EditProfileForm(
                      controller: controller.locationController,
                      label: "Location",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.change_circle,
                            color: CustomColors.accentColor,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Change Password",
                            style: TextStyle(
                              color: CustomColors.accentColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      label: 'Save',
                      onPressed: () {
                        controller.updateProfile();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
