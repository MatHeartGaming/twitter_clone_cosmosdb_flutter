// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final GenericText username;
  final String? imageUrl;
  final XFile? imageFile;
  final Uint8List? imageBytes;

  /// Controllers
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? repeatPasswordController;
  final TextEditingController? nameController;
  final TextEditingController? surnameController;
  final TextEditingController? usernameController;

  const SignupFormState({
    this.status = FormStatus.invalid,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const PasswordText.pure(),
    this.repeatPassword = const PasswordText.pure(),
    this.name = const GenericText.pure(),
    this.surname = const GenericText.pure(),
    this.username = const GenericText.pure(),
    this.emailController,
    this.passwordController,
    this.repeatPasswordController,
    this.nameController,
    this.surnameController,
    this.usernameController,
    this.imageFile,
    this.imageUrl,
    this.imageBytes,
  });

  SignupFormState copyWith({
    FormStatus? status,
    bool? isValid,
    Email? email,
    PasswordText? password,
    PasswordText? repeatPassword,
    GenericText? name,
    GenericText? surname,
    GenericText? username,
    String? imageUrl,
    XFile? imageFile,
    Uint8List? imageBytes,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? repeatPasswordController,
    TextEditingController? nameController,
    TextEditingController? surnameController,
    TextEditingController? usernameController,
  }) => SignupFormState(
    status: status ?? this.status,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    name: name ?? this.name,
    surname: surname ?? this.surname,
    password: password ?? this.password,
    repeatPassword: repeatPassword ?? this.repeatPassword,
    usernameController: usernameController ?? this.usernameController,
    emailController: emailController ?? this.emailController,
    passwordController: passwordController ?? this.passwordController,
    repeatPasswordController:
        repeatPasswordController ?? this.repeatPasswordController,
    nameController: nameController ?? this.nameController,
    surnameController: surnameController ?? this.surnameController,
    username: username ?? this.username,
    imageUrl: imageUrl ?? this.imageUrl,
    imageFile: imageFile ?? this.imageFile,
    imageBytes: imageBytes ?? this.imageBytes,
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
        other.surname == surname;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        isValid.hashCode ^
        email.hashCode ^
        password.hashCode ^
        repeatPassword.hashCode ^
        name.hashCode ^
        surname.hashCode;
  }
}
