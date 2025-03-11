import 'package:formz/formz.dart';
import 'package:twitter_cosmos_db/config/constants/regular_expressions.dart';

enum ZipCodeError { empty, invalid }

class ZipCode extends FormzInput<String, ZipCodeError> {
  // Call super.pure to represent an unmodified form input.
  const ZipCode.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ZipCode.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ZipCodeError.empty) {
      return 'Il codice postale non può essere vuoto';
    }
    if (displayError == ZipCodeError.invalid) {
      return 'Il codice postale non è valido';
    }
    return null;
  }

  @override
  ZipCodeError? validator(String value) {
    if (value.trim().isEmpty) return ZipCodeError.empty;

    // A simple regex for validating zip codes (adjust for your use case)
    if (!zipCodeRegex.hasMatch(value)) {
      return ZipCodeError.invalid;
    }

    return null;
  }
}