import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HumanFormats {
  static String number(BuildContext context, double number,
      {int decimals = 0}) {
    final myLocale = Localizations.localeOf(context).toString();
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: myLocale,
    ).format(number);
    return formattedNumber;
  }

  static String getNumberWithCurrency(BuildContext context, double number,
      {int decimals = 2}) {
    final myLocale = Localizations.localeOf(context).toString();
    final currencyFormat = NumberFormat.currency(
      locale: myLocale,
      symbol: '', // Leave empty to add the symbol manually later
      decimalDigits: decimals,
    );

    String formattedNumber = currencyFormat.format(number);

    // Handle placement of the currency symbol manually
    final symbol = NumberFormat.simpleCurrency(locale: myLocale).currencySymbol;
    return '$symbol$formattedNumber';
  }
}
