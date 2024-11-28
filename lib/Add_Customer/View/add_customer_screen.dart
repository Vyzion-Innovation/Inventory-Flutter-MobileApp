import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Customer/Controller/add_customer_controller.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Extension/form_validator.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_common_button.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

class AddCustomerScreen extends StatelessWidget {
  final AddCustomerController controller = Get.put(AddCustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const CustomAppBar(
        title: AppText( Strings.addCustomer , fontSize: 20, fontWeight: FontWeight.bold,),
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
                controller: controller.supllierName,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateCustomerName,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Phone Number",
                hintText: "Enter Phone Number",
                controller: controller.phoneNumberController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validatePhoneNumber,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Billing Address",
                hintText: "Enter Address",
                controller: controller.supplierAddressController,
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
                      title: Strings.save,
                      onTap: () {
                        controller.saveData();
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Spacing between buttons
                  Expanded(
                    child: CustomButton(
                      title: Strings.saveNext,
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
