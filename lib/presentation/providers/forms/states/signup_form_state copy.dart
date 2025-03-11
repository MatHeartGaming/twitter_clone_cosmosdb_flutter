// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:twitter_cosmos_db/domain/inputs_validations/inputs.dart';
import 'package:twitter_cosmos_db/presentation/providers/forms/states/form_status.dart';

class SignupFormState {
  final FormStatus status;
  final bool isValid;
  final Email email;
  final PasswordText password;
  final PasswordText repeatPassword;
  final GenericText name;
  final GenericText surname;
  final VatNumber vatNumber;
  final GenericText companyName;
  final Phone phoneNumber;

  /// Controllers
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? repeatPasswordController;
  final TextEditingController? nameController;
  final TextEditingController? surnameController;
  final TextEditingController? vatNumberController;
  final TextEditingController? companyNameController;
  final TextEditingController? phoneNumberController;

  const SignupFormState({
    this.status = FormStatus.invalid,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const PasswordText.pure(),
    this.repeatPassword = const PasswordText.pure(),
    this.name = const GenericText.pure(),
    this.surname = const GenericText.pure(),
    this.vatNumber = const VatNumber.pure(),
    this.companyName = const GenericText.pure(),
    this.phoneNumber = const Phone.pure(),
    this.emailController,
    this.passwordController,
    this.repeatPasswordController,
    this.nameController,
    this.surnameController,
    this.vatNumberController,
    this.companyNameController,
    this.phoneNumberController,
  });

  SignupFormState copyWith({
    FormStatus? status,
    bool? isValid,
    Email? email,
    PasswordText? password,
    PasswordText? repeatPassword,
    GenericText? name,
    GenericText? surname,
    VatNumber? vatNumber,
    GenericText? companyName,
    Phone? phoneNumber,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? repeatPasswordController,
    TextEditingController? nameController,
    TextEditingController? surnameController,
    TextEditingController? vatNumberController,
    TextEditingController? companyNameController,
    TextEditingController? phoneNumberController,
  }) =>
      SignupFormState(
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        password: password ?? this.password,
        repeatPassword: repeatPassword ?? this.repeatPassword,
        vatNumber: vatNumber ?? this.vatNumber,
        companyName: companyName ?? this.companyName,
        emailController: emailController ?? this.emailController,
        passwordController: passwordController ?? this.passwordController,
        repeatPasswordController:
            repeatPasswordController ?? this.repeatPasswordController,
        nameController: nameController ?? this.nameController,
        surnameController: surnameController ?? this.surnameController,
        vatNumberController: vatNumberController ?? this.vatNumberController,
        companyNameController:
            companyNameController ?? this.companyNameController,
        phoneNumberController: phoneNumberController ?? this.phoneNumberController,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  bool get isPosting => status == FormStatus.posting;

  @override
  bool operator ==(covariant SignupFormState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.isValid == isValid &&
        other.email == email &&
        other.password == password &&
        other.repeatPassword == repeatPassword &&
        other.name == name &&
        other.surname == surname &&
        other.vatNumber == vatNumber &&
        other.companyName == companyName;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        isValid.hashCode ^
        email.hashCode ^
        password.hashCode ^
        repeatPassword.hashCode ^
        name.hashCode ^
        surname.hashCode ^
        vatNumber.hashCode ^
        companyName.hashCode;
  }
}
