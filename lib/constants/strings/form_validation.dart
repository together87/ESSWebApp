import 'package:strings/strings.dart';

class FormValidationMessage {
  final String fieldName;
  final int? maxLength;
  FormValidationMessage({
    required this.fieldName,
    this.maxLength,
  });

  String get capitalizedFieldName => capitalize(fieldName);

  String get requiredMessage => '$capitalizedFieldName is required.';

  String get alphanumbericWithAllowSpecialCharMessage => '$capitalizedFieldName must contain only alphanumeric characters and special characters.';

  String get alphabeticMessage => '$capitalizedFieldName must contain only alphabets (letters A-Z and a-z).';

  String get numberMessage => '$capitalizedFieldName must contain only numbers.';

  String get alphanumericMessage => '$capitalizedFieldName must contain only alphanumeric characters (letters A-Z, a-z, and numbers 0-9).';

  String get alphanumericWithSpecialCharsMessage => "$capitalizedFieldName must contain only Alphanumeric characters (letters A-Z, a-z, and numbers 0-9) and Special characters (+_-()@&,\\'.).";

  String get maxLengthValidationMessage => '$capitalizedFieldName cannot be more than $maxLength characters.';

  static const String phoneValidationMessage ='Please enter a valid phone number. It should consist of numbers and may include +, optional spaces, dashes or parentheses.';

  static const String einNumberValidationMessage = 'EIN Number can have only number and dashes in the format XX-XXXXXXX.';

  static const String emailValidationMessage = 'Please enter a valid email address.';

  static const String phoneNumberValidationMessage ='Please enter the valid phone number.';
}
