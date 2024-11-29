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
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.name; // "Company Name is required."
    }
    return null;
  }
  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.city; // "Company Name is required."
    }
    return null;
  }
  static String? validatePinCode(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.pinCode; // "Company Name is required."
    }
    return null;
  }
  static String? validateGstNumber(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.gstNumber; // "Company Name is required."
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
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.description; // "Configuration is required."
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
   static String? validateSupllierName(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.suppliersName; // "Item Code is required."
    }
    return null;
    
  }
   static String? validateCustomerName(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.customerName; // "Item Code is required."
    }
    return null;
  }
   static String? validateIsuue(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.issue; // "Item Code is required."
    }
    return null;
  }


  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.phone; // "Company Name is required."
    }
    return null;
  }
   static String? validateEstimatedCost(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.amount; // "Company Name is required."
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.address; // "Brand is required."
    }
    return null;
  }
   static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorMessages.date; // "Brand is required."
    }
    return null;
  }

}
