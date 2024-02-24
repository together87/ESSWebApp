import 'package:intl/intl.dart';

class FormatCurrency {


  FormatCurrency();

  String formatInt(int amount) {
    return NumberFormat.currency(
            locale: 'en_US', symbol: 'USD ', decimalDigits: 2)
        .format(amount);
  }

  String formatDouble(double amount) {
    return NumberFormat.currency(
            locale: 'en_US', symbol: 'USD ', decimalDigits: 2)
        .format(amount);
  }
}
