import 'package:formz/formz.dart';

enum VatError { incorrect }

class VatNumber extends FormzInput<String, VatError> {

  // Call super.pure to represent an unmodified form input.
  const VatNumber.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const VatNumber.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == VatError.incorrect) {
      return 'Partita IVA incorretta';
    }
    return null;
  }

  @override
  VatError? validator(String value) {
    //if (!validateVATNumber(value)) return VatError.incorrect;
    return null;
  }
}
