import 'package:inventoryappflutter/Constant/error_messages.dart';

class FieldValidator {
  static String? validateItemCode(String? value) {
    if ( value?.isEmpty ?? false) {
      print(value);
      return ErrorValidationMessages.itemCode; // "Item Code is required."
    }
    return null;
  }

  static String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.companyName; // "Company Name is required."
    }
    return null;
  }
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.name; // "Company Name is required."
    }
    return null;
  }
  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.city; // "Company Name is required."
    }
    return null;
  }
  static String? validatePinCode(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.pinCode; // "Company Name is required."
    }
    return null;
  }
  static String? validateGstNumber(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.gstNumber; // "Company Name is required."
    }
    return null;
  }

  static String? validateBrand(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.brand; // "Brand is required."
    }
    return null;
  }

  static String? validateModelNumber(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.modelNumber; // "Model Number is required."
    }
    return null;
  }

  static String? validateConfiguration(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.configuration; // "Configuration is required."
    }
    return null;
  }
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.description; // "Configuration is required."
    }
    return null;
  }

  static String? validateSerialNumber(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.serialNumber; // "Serial Number is required."
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
      return ErrorValidationMessages.suppliersName; // "Item Code is required."
    }
    return null;
    
  }
   static String? validateCustomerName(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.customerName; // "Item Code is required."
    }
    return null;
  }
   static String? validateIsuue(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.issue; // "Item Code is required."
    }
    return null;
  }


  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.phone; // "Company Name is required."
    }
    return null;
  }
   static String? validateEstimatedCost(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.amount; // "Company Name is required."
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.address; // "Brand is required."
    }
    return null;
  }
   static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorValidationMessages.date; // "Brand is required."
    }
    return null;
  }

}
