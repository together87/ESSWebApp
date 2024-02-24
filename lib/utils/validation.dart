class Validation {
  static bool isEmpty(String? text) {
    return text == null || (text.isEmpty || text.trim().isEmpty);
  }

  static bool isNotCheckedMin(String? text) {
    return text == null || text.length < 3;
  }

  static bool isNotCheckedMax(String? text) {
    return text == null || text.length > 100;
  }

  static bool isNotChecked2(String? text) {
    return text == null || text.length > 50;
  }

  static bool isNotEmpty(String? text) {
    return text != null && text.trim().isNotEmpty;
  }

  static bool checkAlphanumeric(String str) {
    final alphpanumeric = RegExp(r'^[0-9a-zA-Z ]+$');
    return alphpanumeric.hasMatch(str);
  }

  static bool checkAlphabetic(String str) {
    final alphabetic = RegExp(r'^[a-zA-Z ]+$');
    return alphabetic.hasMatch(str);
  }

  static bool isEmail(String str) {
    final emailReg = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return emailReg.hasMatch(str);
    // return EmailValidator.validate(str);
  }

  static bool isMobilePhone(String str) {
    // final mobile = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    // final mobile =
    //     RegExp(r'^(\+0?1\s)?((\d{3})|(\(\d{3}\)))?(\s|-)\d{3}(\s|-)\d{4}$');
    final mobile = RegExp(
        r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');
    // final mobile = RegExp(r'^[0-9]+.()-$');
    return mobile.hasMatch(str);
  }

  static bool isAlphaNumericWithSpecialChars(String? str) {
    final reg = RegExp(r'^[a-zA-Z0-9]+(?: [a-zA-Z0-9]+)*$');

    return !reg.hasMatch(str!);
  }

  static bool isNumberonly(String? str) {
    final reg = RegExp(r'^[0-9]+$');
    return !reg.hasMatch(str!);
  }
}
