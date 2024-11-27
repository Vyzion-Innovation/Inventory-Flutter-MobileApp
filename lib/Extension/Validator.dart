
import 'package:inventoryappflutter/Extension/constants.dart';

class Validator {
  static Pattern emailPattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,403}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,403}[a-zA-Z0-9])?)*$";
  static RegExp regexEmail = new RegExp(emailPattern.toString());
  static Pattern phonePattern =
      "\\d{9}|(?:\\d{3}-){2}\\d{4}|\\(\\d{3}\\)\\d{3}-?\\d{4}";
  static RegExp regexPhone = new RegExp(phonePattern.toString());

  static validateEmail(String value, String errorTextForEmptyField,
      String errorTextForInvalidField) {
    if (value.isNotEmpty) {
      if (regexEmail.hasMatch(value)) {
        return null;
      } else {
        return errorTextForInvalidField;
      }
    } else {
      return errorTextForEmptyField;
    }
  }

  static validateEmailAndPhone(String value, String errorTextForEmptyField,
      String errorTextForInvalidField) {
    if (value.isNotEmpty) {
      if (regexEmail.hasMatch(value) || regexPhone.hasMatch(value)) {
        return null;
      } else {
        return errorTextForInvalidField;
      }
    }
  }

  static validateFormField(String value, String errorTextForEmptyField,
      String errorTextInvalidField, int type) {
    switch (type) {
      case Constants.MIN_CHAR_VALIDATION:
        if (value.isEmpty) {
          return errorTextForEmptyField;
        } else if (value.length < 2) {
          return errorTextInvalidField;
        }
        break;
      case Constants.NORMAL_VALIDATION:
        if (value.isEmpty) {
          return errorTextForEmptyField;
        }
        break;

      case Constants.EMAIL_VALIDATION:
        return validateEmail(
            value, errorTextForEmptyField, errorTextInvalidField);

      case Constants.PHONE_VALIDATION:
        if (value.isNotEmpty) {
          if (isNumeric(value) && value.length <= 13) {
            return null;
          } else {
            return errorTextInvalidField;
          }
        } else {
          return errorTextForEmptyField;
        }

      case Constants.PHONE_OR_EMAIL_VALIDATION:
        return validateEmailAndPhone(
            value, errorTextForEmptyField, errorTextInvalidField);

      case Constants.PASSWORD_VALIDATION:
        if (value.isNotEmpty) {
          if (value.length >= 8) {
            return null;
          } else {
            return errorTextInvalidField;
          }
        } else {
          return errorTextForEmptyField;
        }

      case Constants.ZIP_VALIDATION:
        if (value.isNotEmpty) {
          if (value.length == 6) {
            return null;
          } else {
            return errorTextInvalidField;
          }
        } else {
          return errorTextForEmptyField;
        }
    }
  }

  static bool isNumeric(String str) {
    try {
      var value = double.parse(str);
    } on FormatException {
      return false;
    } finally {
      return true;
    }
  }
}

class BoolExtension {
  bool containsAny(List<String> text, List<String> substrings) {
    // returns true if any substring of the [substrings] list is contained in the [text]
    for (var substring in substrings) {
      if (text.contains(substring)) return true;
    }
    return false;
  }
}
