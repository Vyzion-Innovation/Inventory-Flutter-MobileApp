import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/firebase_collection.dart';
import 'package:inventoryappflutter/Model/repair_model.dart';

class RepairFormController extends GetxController {
  // Form Key
  final formKey = GlobalKey<FormState>();
  // Text Controllers
  final customeNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final issueController = TextEditingController();
  final estimatedCostController = TextEditingController();
  final modelNumberController = TextEditingController();
  final statusController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final finalCostController = TextEditingController();

  // Dropdown state

  var selectedStatus = ''.obs;

  // Dropdown options
  final items = ['Receive', 'Complete'];

  RepairModel? repairData;
  // Set the inventory data when editing
  void setRepairData(RepairModel repair) {
    repairData = repair;
    customeNameController.text = repair.customerName ?? '';
    phoneNumberController.text = repair.phone ?? '';
    issueController.text = repair.issue ?? '';
    estimatedCostController.text = repair.estimatedCost ?? '';
    modelNumberController.text = repair.model ?? '';
    selectedStatus.value = repair.status ?? '';
    descriptionController.text = repair.description ?? '';
  
      dateController.text = repair.completeDate ?? '';
      finalCostController.text = repair.finalCost ?? '';
    
  }
   @override
  void refresh() {
     formKey.currentState?.reset();
     customeNameController.clear();
   phoneNumberController.clear();
   issueController.clear();
   modelNumberController.clear();
   estimatedCostController.clear();
   modelNumberController.clear();
   statusController.clear();
   descriptionController.clear();
   dateController.clear();
   finalCostController.clear();
  
   selectedStatus.value = '';
 
  }

  // Save Data Method
  Future<void> saveData(String buttonType) async {
    if (buttonType.toLowerCase() == 'save') {
      if (formKey.currentState!.validate()) {
        if (repairData != null) {
          await _updateRepairItem(); // Call to update the existing customer
        } else {
          await _saveRepairItem(); // Call to save the new customer
        }
        Get.back(result: true); // Close screen and pass success
      }
    } else if (buttonType.toLowerCase() == 'save+next') {
      if (formKey.currentState!.validate()) {
        await _saveRepairItem(); // Save inventory data
        refresh(); // Reset form for new entry
      }
    }
  }

  Future<void> _saveRepairItem() async {
    try {
      // Parse the purchase date and convert it to a timestamp
      String generateUniqueNumber([DateTime? date]) {
        date ??= DateTime.now(); // Use current date-time if not provided
        return date.millisecondsSinceEpoch.toRadixString(36);
      }

      RepairModel repair = RepairModel(
          issue: issueController.text,
          phone: phoneNumberController.text,
          estimatedCostNum: int.tryParse(estimatedCostController.text) ?? 0,
          estimatedCost: estimatedCostController.text,
          jobNumber: generateUniqueNumber(),
          customerName: customeNameController.text,
          status: selectedStatus.value,
          model: modelNumberController.text,
          description: descriptionController.text,
          createdAt: DateTime.now().millisecondsSinceEpoch);

      // Convert the object to JSON
      Map<String, dynamic> repairData = repair.toJson();

      // Add the inventory data to Firestore
      await FirestoreCollections.repairs.add(repairData);

      print("Inventory data saved successfully.");
    } catch (e) {
      print("Error saving inventory data: $e");
    }
  }

  Future<void> _updateRepairItem() async {
    try {
      if (repairData == null) {
      
        return;
      }

      // Parse the completion date if provided
      int completeDateTimeStamp = 0;
      if (dateController.text.isNotEmpty) {
        try {
          DateTime parsedDate = DateTime.parse(dateController.text);
          completeDateTimeStamp = parsedDate.millisecondsSinceEpoch;
        } catch (e) {
          print("Error parsing completion date: $e");
        }
      }

      // Create the updated repair model
      RepairModel updatedRepair = RepairModel(
        issue: issueController.text,
        phone: phoneNumberController.text,
        estimatedCostNum: int.tryParse(estimatedCostController.text) ?? 0,
        estimatedCost: estimatedCostController.text,
        jobNumber: repairData!.jobNumber, // Keep the original job number
        customerName: customeNameController.text,
        status: selectedStatus.value,
        model: modelNumberController.text,
        description: descriptionController.text,
        createdAt: repairData!.createdAt, // Keep the original creation date
        completeDate: dateController.text,
        completeTimestamp: completeDateTimeStamp,
        finalCost: finalCostController.text,
        finalCostNum: int.tryParse(finalCostController.text) ?? 0,
        updatedAt: DateTime.now().millisecondsSinceEpoch
      );

      // Convert the object to JSON
      Map<String, dynamic> updatedRepairData = updatedRepair.toJson();

      // Update the document in Firestore
      DocumentReference repairRef =  FirestoreCollections.repairs.doc(repairData?.id);

      await repairRef.update(updatedRepairData);

      print("Repair data updated successfully.");
    } catch (e) {
      print("Error updating repair data: $e");
    }
  }

  void cancelSaving() {
    Get.back();
  }
}
