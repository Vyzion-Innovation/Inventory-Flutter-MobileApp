import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Inventory/Controller/add_inventory_controller.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Extension/form_validator.dart';
import 'package:inventoryappflutter/Model/customer_model.dart';
import 'package:inventoryappflutter/Model/inventory_model.dart';
import 'package:inventoryappflutter/Model/supplier_model.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_common_button.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/common_drop_down_text_field.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

class InventoryFormScreen extends StatelessWidget {
  final InventoryFormController controller = Get.put(InventoryFormController());
  InventoryFormScreen({Key? key, InventoryModel? inventory}) : super(key: key) {
    // If a customer object is passed, set it for editing
    if (inventory != null) {
      controller.setInventoryData(inventory);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: AppText(
         controller.inventoryData == null ? Strings.addInventory : 'Edit Inventory',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
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
                controller: controller.serialNumberController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateSerialNumber,
              ),
              const SizedBox(height: 20),
              Obx(() => CommonDropDownTextField(
                    labelText: "Status",
                    hintText: "Select Status",
                    value: controller.selectedStatus.value.isEmpty
                        ? null
                        : controller.selectedStatus.value,
                    items: controller.items
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        controller.selectedStatus.value = value ?? '',
                    validator: (value) =>
                        value == null || value.isEmpty ? "Required" : null,
                    fillColor: AppColors.colorWhite,
                   borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                  )),
              const SizedBox(height: 20),

              Obx(() {
                if (controller.selectedStatus.value == "Sell") {
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        validator: FieldValidator.validateEstimatedCost,
                      ),
                      const SizedBox(height: 20),
                      Obx(() => CommonDropDownTextField<CustomerModel>(
                            labelText: "Buyer",
                            hintText: "Select Buyer",
                            value: (controller.selectedBuyer.value == null
                                ? null
                                : controller.buyers[controller.buyers
                                    .indexWhere((item) =>
                                        item.name ==
                                        controller.selectedBuyer.value?.name)]),
                            items: controller.buyers
                                .map((item) => DropdownMenuItem<CustomerModel>(
                                      value: item,
                                      child: Text(
                                          '${item.name} ${item.phone}'), // Display name and phone
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.selectedBuyer.value =
                                    value; // Update the observable
                              } // Set the selected buyer
                            },
                            validator: (value) =>
                                value == null ? "Required" : null,
                            fillColor: Colors.white,
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor, width: 1.0),
                          )),
                      const SizedBox(height: 20),
                      Obx(() => CommonDropDownTextField(
                            labelText: "Paid by",
                            hintText: "Select Paid Method",
                            value: controller.selectedPaidBy.value.isEmpty
                                ? null
                                : controller.selectedPaidBy.value,
                            items: controller.paidBy
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                            onChanged: (value) =>
                                controller.selectedPaidBy.value = value ?? '',
                            validator: (value) => value == null || value.isEmpty
                                ? "Required"
                                : null,
                            fillColor: AppColors.colorWhite,
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor, width: 1.0),
                          )),
                    ],
                  );
                } else if (controller.selectedStatus.value == "Stock") {
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
                        controller: controller.purchaseAmountController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        validator: FieldValidator.validateEstimatedCost,
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        return CommonDropDownTextField<SupplierModel>(
                          labelText: "Seller",
                            hintText: "Select Seller",
                          value: (controller.selectedSeller.value == null
                              ? null
                              : controller.sellers[controller.sellers
                                  .indexWhere((item) =>
                                      item.name ==
                                      controller.selectedSeller.value?.name)]),
                          // controller
                          //     .selectedSeller.value, // Use the observable value
                          items: controller.sellers.map((SupplierModel seller) {
                            return DropdownMenuItem<SupplierModel>(
                              value: seller,
                              child: Text('${seller.name} (${seller.phone})'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              print(value);
                              controller.selectedSeller.value =
                                  value; // Update the observable
                            }
                          },
                          borderSide: const BorderSide(
                                color: AppColors.primaryColor, width: 1.0),
                          validator: (value) =>
                              value == null ? 'Please select a seller' : null,
                        );
                      }),
                    ],
                  );
                }
                return SizedBox();
              }),
             const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Adjust alignment as needed
                children: [
                  Expanded(
                    child: CustomButton(
                       title: controller.inventoryData == null ? Strings.save : 'Update',
                      onTap: () {
                        controller.saveData('save');
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Spacing between buttons
                  if(controller.inventoryData == null)...[
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
