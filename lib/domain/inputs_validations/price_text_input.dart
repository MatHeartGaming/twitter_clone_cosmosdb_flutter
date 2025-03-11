import 'package:formz/formz.dart';

enum PriceError { empty, tooLow }

class Price extends FormzInput<String, PriceError> {
  final double _minPrice = 0.01;

  // Call super.pure to represent an unmodified form input.
  const Price.pure() : super.pure('0');

  // Call super.dirty to represent a modified form input.
  const Price.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PriceError.empty) {
      return 'Il prezzo non può essere vuoto';
    }
    if (displayError == PriceError.tooLow) {
      return 'Il prezzo deve avere almeno $_minPrice';
    }
    return null;
  }

  @override
  PriceError? validator(String value) {
    if (value.trim().isEmpty) return PriceError.empty;
    double price = double.tryParse(value.replaceAll(',', '')) ?? 0;
    if (price <= 0) return PriceError.tooLow;
    return null;
  }
}
