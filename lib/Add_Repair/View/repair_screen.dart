import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Repair/Controller/repair_controller.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Extension/form_validator.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_common_button.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/common_drop_down_text_field.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

class RepairFormScreen extends StatelessWidget {
  final RepairFormController controller = Get.put(RepairFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const CustomAppBar(
        title: AppText( Strings.repair , fontSize: 20, fontWeight: FontWeight.bold,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              CustomTextField(
                labelText: "Customer Name",
                hintText: "Enter name",
                controller: controller.customeNameController,
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
                labelText: "Issue",
                hintText: "Enter Issue",
                controller: controller.issueController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateIsuue,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Estimated Cost",
                hintText: "Enter Estimated Cost",
                controller: controller.estimatedCostController,
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                validator: FieldValidator.validateEstimatedCost,
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
                CustomTextField(
                        labelText: "Description",
                        hintText: "Enter Description",
                        controller: controller.descriptionController,
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        validator: FieldValidator.validateDescription,
                      ),
                        const SizedBox(height: 20),
              Obx(() {
                if (controller.selectedDropdownItem.value == "Complete") {
                  return Column(
                    children: [
                      CustomTextField(
                        labelText: "Complete Date",
                        hintText: "Enter Date",
                        controller: controller.dateController,
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
                              controller.dateController.text =
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
                        labelText: "Final Cost",
                        hintText: "Enter Final Cost",
                        controller: controller.finalCostController,
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        validator: FieldValidator.validateEstimatedCost,
                      ),
                     
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
