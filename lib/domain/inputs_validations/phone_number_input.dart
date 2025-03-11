import 'package:formz/formz.dart';
import 'package:twitter_cosmos_db/config/constants/regular_expressions.dart';

enum PhoneNumberError { empty, format }

class Phone extends FormzInput<String, PhoneNumberError> {
  // Call super.pure to represent an unmodified form input.
  const Phone.pure() : super.pure('0');

  // Call super.dirty to represent a modified form input.
  const Phone.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PhoneNumberError.empty) {
      return 'Il numero non può essere vuoto';
    }
    if (displayError == PhoneNumberError.format) {
      return 'Il formato non è corretto';
    }
    return null;
  }

  @override
  PhoneNumberError? validator(String value) {
    if (value.trim().isEmpty) return PhoneNumberError.empty;
    if (!isValidPhoneNumber(value)) return PhoneNumberError.format;
    return null;
  }
}
