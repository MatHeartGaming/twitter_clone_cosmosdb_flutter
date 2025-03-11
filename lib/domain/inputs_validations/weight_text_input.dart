import 'package:formz/formz.dart';

enum WeightError { empty, tooLow }

class Weight extends FormzInput<String, WeightError> {
  final double _minWeight = 0.01;

  // Call super.pure to represent an unmodified form input.
  const Weight.pure() : super.pure('0');

  // Call super.dirty to represent a modified form input.
  const Weight.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == WeightError.empty) {
      return 'Il peso non può essere vuoto';
    }
    if (displayError == WeightError.tooLow) {
      return 'Il peso deve avere almeno $_minWeight';
    }
    return null;
  }

  @override
  WeightError? validator(String value) {
    if (value.trim().isEmpty) return WeightError.empty;
    double price = double.tryParse(value.replaceAll(',', '')) ?? 0;
    if (price <= 0) return WeightError.tooLow;
    return null;
  }
}
