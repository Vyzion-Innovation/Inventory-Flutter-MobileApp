import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inventoryappflutter/Add_Customer/Controller/add_customer_controller.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Extension/form_validator.dart';
import 'package:inventoryappflutter/Model/customer_model.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_common_button.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

class AddCustomerScreen extends StatelessWidget {
  final AddCustomerController controller = Get.put(AddCustomerController());

  AddCustomerScreen({Key? key, CustomerModel? customer}) : super(key: key) {
    // If a customer object is passed, set it for editing
    if (customer != null) {
      controller.setCustomerData(customer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: AppText(
        controller.customerToEdit == null ? Strings.addCustomer : 'Edit Customer',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
         isLeading: true,
        onTapLeading: () {
          Get.back(result: true);
          print('Leading widget tapped!');
          // You can also navigate or perform other actions here
        },
      ),
      body: controller.isLoader.value
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: controller.formKey,
                child: ListView(
                  children: [
                     const SizedBox(height: 10),
                    CustomTextField(
                      labelText: "Name",
                      hintText: "Enter name",
                      controller: controller.customerName,
                      borderSide:
                          const BorderSide(color: AppColors.primaryColor, width: 1.0),
                      validator: FieldValidator.validateCustomerName,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      labelText: "Phone Number",
                      hintText: "Enter Phone Number",
                      controller: controller.phoneNumberController,
                     inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10)
                        ],
                         input: TextInputType.number,
                      borderSide:
                          const BorderSide(color: AppColors.primaryColor, width: 1.0),
                      validator: FieldValidator.validatePhoneNumber,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      labelText: "Billing Address",
                      hintText: "Enter Address",
                      controller: controller.customerAddressController,
                      MaxLine: 4,
                      borderSide:
                          const BorderSide(color: AppColors.primaryColor, width: 1.0),
                      validator: FieldValidator.validateAddress,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomButton(
                            title: controller.customerToEdit == null ? Strings.save : 'Update',
                            onTap: () {
                              controller.saveData('save');
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        if(controller.customerToEdit == null)...[
                        Expanded(
                          child: CustomButton(
                            title: Strings.saveNext,
                            onTap: () {
                              controller.saveData('save+next');
                            },
                          ),
                        ),
                        ],
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            title: Strings.cancel,
                            onTap: () {
                              controller.cancelSaving();
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
