import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Supplier/Controller/add_supllier_controller.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Extension/form_validator.dart';
import 'package:inventoryappflutter/Model/supplier_model.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_common_button.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

class AddSupplierScreen extends StatelessWidget {
  final SupplierFormController controller = Get.put(SupplierFormController());

   AddSupplierScreen({Key? key, SupplierModel? supplier}) : super(key: key) {
    // If a customer object is passed, set it for editing
    if (supplier != null) {
      controller.setSupplierData(supplier);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:  CustomAppBar(
        title: AppText(controller.supplierToEdit == null ? Strings.addSupplier : " Edit Supplier", fontSize: 20, fontWeight: FontWeight.bold,),
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
                controller: controller.supplierName,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateSupllierName,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Phone Number",
                hintText: "Enter Phone Number",
                controller: controller.phoneNumberController,
                 inputFormatters: [FilteringTextInputFormatter.digitsOnly] ,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validatePhoneNumber,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Address",
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
                      title: controller.supplierToEdit == null ? Strings.save : 'Update',
                      onTap: () {
                        controller.saveData('save');
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Spacing between buttons
                    if(controller.supplierToEdit == null)...[
                  Expanded(
                    child: CustomButton(
                      title: Strings.saveNext,
                      onTap: () {
                        controller.saveData('save+next');
                      },
                    ),
                  ),
                    ],
                  SizedBox(width: 10), // Spacing between buttons
                  Expanded(
                    child: CustomButton(
                      title: Strings.cancel,
                      onTap: () {
                        controller.cancelsaving();
                         Get.back(result: true);
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
