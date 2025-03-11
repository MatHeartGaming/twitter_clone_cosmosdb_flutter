import 'package:formz/formz.dart';
import 'package:twitter_cosmos_db/config/constants/regular_expressions.dart';

enum CivicNumberError { empty, invalid }

class CivicNumber extends FormzInput<String, CivicNumberError> {
  // Call super.pure to represent an unmodified form input.
  const CivicNumber.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const CivicNumber.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == CivicNumberError.empty) {
      return 'Il numero civico non può essere vuoto';
    }
    if (displayError == CivicNumberError.invalid) {
      return 'Il numero civico non è valido';
    }
    return null;
  }

  @override
  CivicNumberError? validator(String value) {
    if (value.trim().isEmpty) return CivicNumberError.empty;

    // A simple regex for validating civic numbers (adjust for your use case)
    if (!civicNumberRegex.hasMatch(value)) {
      return CivicNumberError.invalid;
    }

    return null;
  }
}
