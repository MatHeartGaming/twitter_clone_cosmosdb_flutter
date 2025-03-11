import 'package:formz/formz.dart';

enum GenericTextError { empty, length }

class GenericText extends FormzInput<String, GenericTextError> {
  final int _minLenght = 3;

  // Call super.pure to represent an unmodified form input.
  const GenericText.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const GenericText.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == GenericTextError.empty) {
      return 'Il campo non può essere vuoto';
    }
    if (displayError == GenericTextError.length) {
      return 'Il campo deve avere almeno $_minLenght caratteri';
    }
    return null;
  }

  @override
  GenericTextError? validator(String value) {
    if (value.trim().isEmpty) return GenericTextError.empty;
    if (value.trim().length < _minLenght) return GenericTextError.length;
    return null;
  }
}
