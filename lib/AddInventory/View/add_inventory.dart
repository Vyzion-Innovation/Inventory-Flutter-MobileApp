import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/AddInventory/Controller/add_inventory_controller.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Constant/error_messages.dart';
import 'package:inventoryappflutter/Extension/form_validator.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_common_button.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/common_drop_down_text_field.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

class InventoryFormScreen extends StatelessWidget {
  final InventoryFormController controller = Get.put(InventoryFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const CustomAppBar(
        title: AppText( Strings.inventory , fontSize: 20, fontWeight: FontWeight.bold,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              CustomTextField(
                labelText: "Item Code",
                hintText: "Enter Item Code",
                controller: controller.itemCodeController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateItemCode,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Company Name",
                hintText: "Enter Company Name",
                controller: controller.companyNameController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateCompanyName,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Brand",
                hintText: "Enter Brand",
                controller: controller.brandController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateBrand,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Model Number",
                hintText: "Enter Model Number",
                controller: controller.modelNumberController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateModelNumber,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Configuration",
                hintText: "Enter Configuration",
                controller: controller.configurationController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateConfiguration,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Serial Number",
                hintText: "Enter Serial Number",
                controller: controller.modelNumberController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateSerialNumber,
              ),
              const SizedBox(height: 20),
              Obx(() => CommonDropDownTextField(
                    labelText: "Status",
                    hintText: "Select Status",
                    value: controller.selectedDropdownItem.value.isEmpty
                        ? null
                        : controller.selectedDropdownItem.value,
                    items: controller.items
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        controller.selectedDropdownItem.value = value ?? '',
                    validator: (value) =>
                        value == null || value.isEmpty ? "Required" : null,
                    fillColor: AppColors.colorWhite,
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor, width: 1.0),
                  )),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.selectedDropdownItem.value == "Sell") {
                  return Column(
                    children: [
                      CustomTextField(
                        labelText: "Sell Date",
                        hintText: "Enter Sell Date",
                        controller: controller.sellDateController,
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        suffix: IconButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.now(), // Current date as the default
                              firstDate:
                                  DateTime(2000), // Earliest selectable date
                              lastDate:
                                  DateTime(2100), // Latest selectable date
                            );
                            if (pickedDate != null) {
                              // Format date and update the controller
                              controller.sellDateController.text =
                                  "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                            }
                          },
                          icon: Icon(
                            Icons.calendar_month,
                          ),
                        ),
                        validator: FieldValidator.validateDate,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        labelText: "Sell Amount",
                        hintText: "Enter Sell Amount",
                        controller: controller.sellAmountController,
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        validator: FieldValidator.validateEstimatedCost,
                      ),
                      const SizedBox(height: 20),
                      Obx(() => CommonDropDownTextField(
                            labelText: "Buyer",
                            hintText: "Select Buyer",
                            value: controller.selectedBuyer.value.isEmpty
                                ? null
                                : controller.selectedBuyer.value,
                            items: controller.buyer
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                            onChanged: (value) =>
                                controller.selectedBuyer.value = value ?? '',
                            validator: (value) =>
                        value == null || value.isEmpty ? "Required" : null,
                            fillColor: AppColors.colorWhite,
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor, width: 1.0),
                          )),
                    ],
                  );
                } else if (controller.selectedDropdownItem.value == "Stock") {
                  return Column(
                    children: [
                      CustomTextField(
                        labelText: "Purchase Date",
                        hintText: "Enter Purchase Date",
                        controller: controller.purchaseDateController,
                        suffix: IconButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.now(), // Current date as the default
                              firstDate:
                                  DateTime(2000), // Earliest selectable date
                              lastDate:
                                  DateTime(2100), // Latest selectable date
                            );
                            if (pickedDate != null) {
                              // Format date and update the controller
                              controller.purchaseDateController.text =
                                  "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                            }
                          },
                          icon: Icon(
                            Icons.calendar_month,
                          ),
                        ),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        validator: FieldValidator.validateDate,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        labelText: "Purchase Amount",
                        hintText: "Enter Purchase Amount",
                        controller: controller.amountController,
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        validator: FieldValidator.validateEstimatedCost,
                      ),
                      const SizedBox(height: 20),
                      Obx(() => CommonDropDownTextField(
                            labelText: "Seller",
                            hintText: "Select Seller",
                            value: controller.selectedSeller.value.isEmpty
                                ? null
                                : controller.selectedSeller.value,
                            items: controller.seller
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                            onChanged: (value) =>
                                controller.selectedSeller.value = value ?? '',
                            validator: (value) =>
                        value == null || value.isEmpty ? "Required" : null,
                            fillColor: AppColors.colorWhite,
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor, width: 1.0),
                          )),
                    ],
                  );
                }
                return SizedBox();
              }),
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
