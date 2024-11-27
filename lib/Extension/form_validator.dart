import 'package:inventoryappflutter/Constant/error_messages.dart';

class FieldValidator {
  static String? validateItemCode(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.itemCode; // "Item Code is required."
    }
    return null;
  }

  static String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.companyName; // "Company Name is required."
    }
    return null;
  }

  static String? validateBrand(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.brand; // "Brand is required."
    }
    return null;
  }

  static String? validateModelNumber(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.modelNumber; // "Model Number is required."
    }
    return null;
  }

  static String? validateConfiguration(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.configuration; // "Configuration is required."
    }
    return null;
  }

  static String? validateSerialNumber(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.serialNumber; // "Serial Number is required."
    }
    return null;
  }

  static String? validateDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "$fieldName is required.";
    }
    return null;
  }
}
