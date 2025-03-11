import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/domain/inputs_validations/inputs.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/providers/forms/states/form_status.dart';
import 'package:twitter_cosmos_db/presentation/providers/forms/states/signup_form_state.dart';

final signupFormProvider =
    StateNotifierProvider.autoDispose<SignupNotifier, SignupFormState>((ref) {
  final signupNotifier = SignupNotifier();
  return signupNotifier;
});

class SignupNotifier extends StateNotifier<SignupFormState> {
  SignupNotifier()
      : super(SignupFormState(
          nameController: TextEditingController(),
          surnameController: TextEditingController(),
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
          repeatPasswordController: TextEditingController(),
          vatNumberController: TextEditingController(),
          companyNameController: TextEditingController(),
          phoneNumberController: TextEditingController(),
        ));

  @override
  void dispose() {
    state.nameController?.dispose();
    state.surnameController?.dispose();
    state.emailController?.dispose();
    state.passwordController?.dispose();
    state.repeatPasswordController?.dispose();
    state.vatNumberController?.dispose();
    state.companyNameController?.dispose();
    state.phoneNumberController?.dispose();
    super.dispose();
  }

  void initFormField(User user) {
    state.nameController?.text = user.nome;
    state.surnameController?.text = user.cognome;
    state = state.copyWith(
      nameController: state.nameController,
      surnameController: state.surnameController,
      emailController: state.emailController,
      vatNumberController: state.vatNumberController,
      companyNameController: state.companyNameController,
      phoneNumberController: state.phoneNumberController,
      name: GenericText.dirty(user.nome),
      surname: GenericText.dirty(user.cognome),
      email: Email.dirty(user.email),
      status: FormStatus.invalid,
      isValid: false,
    );
  }

  void onSubmit(
      {required VoidCallback onSubmit,
      bool validatePasswords = true,
      bool allowNonVatUserSignup = true,
      VoidCallback? onPasswordMismatch}) {
    List<FormzInput> fieldsToValidate = [
      state.email,
      state.name,
      state.surname,
      state.password,
      state.repeatPassword,
    ];

    if (!validatePasswords) {
      fieldsToValidate.removeRange(
          fieldsToValidate.length - 2, fieldsToValidate.length);
      logger.i('Validate pwd length: ${fieldsToValidate.length}');
    }

    state = state.copyWith(
      status: FormStatus.posting,
      email: Email.dirty(state.email.value),
      name: GenericText.dirty(state.name.value),
      surname: GenericText.dirty(state.surname.value),
      password: PasswordText.dirty(state.password.value),
      repeatPassword: PasswordText.dirty(state.repeatPassword.value),
      isValid: Formz.validate(fieldsToValidate),
    );

    if (state.password != state.repeatPassword) {
      if (onPasswordMismatch == null) return;
      onPasswordMismatch();
      return;
    }

    if (!state.isValid) return;

    onSubmit();
  }

  void nameChanged(String value) {
    final name = GenericText.dirty(value);
    List<FormzInput> fieldsToValidate = [
      name,
      state.surname,
      state.email,
      state.password,
      state.repeatPassword
    ];
    state = state.copyWith(
      name: name,
      isValid: Formz.validate(fieldsToValidate) &&
          state.password == state.repeatPassword,
    );
  }

  void surnameChanged(String value) {
    final surname = GenericText.dirty(value);
    List<FormzInput> fieldsToValidate = [
      state.name,
      surname,
      state.email,
      state.password,
      state.repeatPassword
    ];
    state = state.copyWith(
      surname: surname,
      isValid: Formz.validate(fieldsToValidate) &&
          state.password == state.repeatPassword,
    );
  }

  void passwordChanged(String value) {
    final password = PasswordText.dirty(value);
    List<FormzInput> fieldsToValidate = [
      state.name,
      state.surname,
      state.email,
      password,
      state.repeatPassword
    ];
    state = state.copyWith(
      password: password,
      isValid:
          Formz.validate(fieldsToValidate) && password == state.repeatPassword,
    );
  }

  void repeatPasswordChanged(String value) {
    final repeatPassword = PasswordText.dirty(value);
    List<FormzInput> fieldsToValidate = [
      state.name,
      state.surname,
      state.email,
      state.password,
      repeatPassword
    ];
    state = state.copyWith(
      repeatPassword: repeatPassword,
      isValid:
          Formz.validate(fieldsToValidate) && state.password == repeatPassword,
    );
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    List<FormzInput> fieldsToValidate = [
      email,
      state.password,
      state.name,
      state.surname,
    ];
    state = state.copyWith(
      email: email,
      isValid: Formz.validate(fieldsToValidate) &&
          state.password == state.repeatPassword,
    );
  }

  void clearFormState() {
    state = state.copyWith(
      email: const Email.pure(),
      name: const GenericText.pure(),
      surname: const GenericText.pure(),
      vatNumber: const VatNumber.pure(),
      companyName: const GenericText.pure(),
      password: const PasswordText.pure(),
      repeatPassword: const PasswordText.pure(),
      phoneNumber: const Phone.pure(),
    );
  }
}
