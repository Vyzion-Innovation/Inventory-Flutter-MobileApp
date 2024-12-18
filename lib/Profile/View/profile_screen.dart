import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Extension/form_validator.dart';
import 'package:inventoryappflutter/Model/profile_model.dart';
import 'package:inventoryappflutter/Profile/Controller/profile_controller.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_common_button.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
 ProfileScreen({Key? key, ProfileModel? profileData}) : super(key: key) {
    // If a customer object is passed, set it for editing
    if (profileData != null) {
      controller.setProfileData(profileData);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const CustomAppBar(
        title: AppText( Strings.addProfile , fontSize: 20, fontWeight: FontWeight.bold,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              CustomTextField(
                labelText: "Name",
                hintText: "Enter name",
                controller: controller.nameController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateSupllierName,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: "Phone Number",
                hintText: "Enter phone number",
                controller: controller.phoneNumberController,
                // input: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly] ,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validatePhoneNumber,
              ),
               const SizedBox(height: 10),
                            CustomTextField(
                labelText: "City",
                hintText: "Enter your city",
                controller: controller.cityController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateCity,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: "Role",
                hintText: "Admin",
                controller: controller.roleName,
                enabled: false,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validatePhoneNumber,
              ),
               const SizedBox(height: 10),

                            CustomTextField(
                labelText: "Pincode",
                hintText: "Enter pin code",
                controller: controller.pincodeController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validatePinCode,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: "GST Number",
                hintText: "Enter your GST number",
                controller: controller.gstNumberController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateGstNumber,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: "Address",
                hintText: "Enter address",
                controller: controller.addressController,
                 MaxLine: 4,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateAddress,
              ),
             
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Adjust alignment as needed
                children: [
                  Expanded(
                    child: CustomButton(
                      title: controller.adminProfileData != null ? 'Update' : Strings.saveProfile,
                      onTap: () {
                       controller.saveData();
                      },
                    ),
                  ),
                 
                  SizedBox(width: 10), // Spacing between buttons
                  Expanded(
                    child: CustomButton(
                      title: Strings.cancel,
                      onTap: () {
                        controller.cancelsaving();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
