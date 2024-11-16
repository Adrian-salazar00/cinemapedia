import 'package:intl/intl.dart';




class HumanFormats{


  static String number( double number, [ int decimal = 0 ] ) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
      locale: 'en'

    ).format(number);

    return formatterNumber;
  }
}